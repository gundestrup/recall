require 'csv'
class PilesController < ApplicationController
  before_filter :login_required, :except =>  [ :show, :learn, :feed, :index ]
  
  def index
        @piles = Pile.paginate :per_page => 10, :page => params[:page],
                    :conditions => ["name LIKE ?", "%#{params[:search]}%"]    
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  #verify :method => :post, :only => [ :create, :update, :sort ],
  #       :redirect_back_or_default => { :action => :show }

    def show
        @pile = Pile.find(:first, :conditions => ["id = ?", params[:id]])
      if @pile == nil or params[:id] == nil
          redirect_back_or_default(:controller => "search")
            flash[:error] = "Error, no piles found"
      else
        session[:pil] = @pile
        respond_to do |format|
          format.html                    
          format.xml  { render :xml => @pile.to_xml(:include => [:cards, :category], :except => :user_id) }
          format.json  { render :json => @pile.to_json(:include => [:cards, :category], :except => :user_id) }
        end
      end
              
    end

    def learn
        @pile = Pile.find(:first, :conditions => ["id = ?", params[:id]])
        if @pile == nil or params[:id] == nil
          redirect_back_or_default(:controller => "search")
          flash[:error] = "Error, no piles found"
        else
            @cards = Card.paginate :per_page => 1, :page => params[:page],
                                              :conditions => ["pile_id LIKE ?", @pile.id],
                                              :order => 'position ASC'
            @pile.update_attribute(:popularity, @pile.popularity+1)

        respond_to do |format|
            format.html
            format.xml  { render :xml => @pile }
            format.json  { render :json => @pile }            
            format.mobile
        end
        
        end        
    end
  
  def new  	
    @category_id = session[:cat].id
    #@piles.category_id = session[:cat]
    @pile = Pile.new
  end

  def new_pile
    @pilenew = Pile.new
  end

  def create_new
    @pile = Pile.new(params[:pile])
    @pile.user_id=current_user.id
    if @pile.save
      flash[:notice] = 'Pile was successfully created.'
      #redirect_to :action => 'list'
      redirect_back_or_default :controller => "piles", :action => 'show', :id => @pile.id
      #_or_default :action => 'list'
    else
      render :action => 'new'
    end
  end

  def create
    @pile = Pile.new(params[:pile])
    @pile.category_id=session[:cat].id
    @pile.user_id=current_user.id
    if @pile.save
      flash[:notice] = 'Pile was successfully created.'
      #redirect_to :action => 'list'
      redirect_back_or_default :controller => "piles", :action => 'show', :id => @pile.id
      #_or_default :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def create_card
    @card = Card.new(params[:card])
    @card.head = @card.front    
    @card.user_id = current_user.id
    if request.xml_http_request?
      if @card.save
        flash[:notice] = 'Card was successfully created.'
        @pile = Pile.find(:first, :conditions => ["id = ?", @card.pile_id])                
        render :partial => 'cards', :id => @card.pile_id, :layout => false

      else
        flash[:error] = 'Error please try again'        
        render :partial => 'cards', :id => @card.pile_id, :layout => false
      end
    end
  end

  def sort
    params[:cardlist].each_with_index do |id, index|
        Card.update_all(['position=?', index+1], ['id=?', id])
      end
    render :nothing => true
  end


  def edit
    @pile = Pile.find(params[:id])
    if current_user.id == @pile.user_id or current_user.admin?
    else
      flash[:notice] = 'Sorry, you can\'t edit other peoples piles'
      redirect_back_or_default :controller => "accounts", :action => "index"
    end
  end

  def update
    @pile = Pile.find(params[:id])
    if @pile.update_attributes(params[:pile])
      flash[:notice] = 'Pile was successfully updated.'
      redirect_to :action => 'show', :id => @pile
    else
      render :action => 'edit'
    end
  end

  def destroy
    @pile = Pile.find(params[:id])
    if current_user.id == @pile.user_id or current_user.admin?
       @pile.destroy       

    redirect_back_or_default :controller => "accounts", :action => "account"
    flash[:notice] = 'Pile deleted'
    else
      flash[:notice] = 'Sorry, you can\'t delete other peoples piles'
      redirect_back_or_default :action => "index"
    end
  end
    
  def csv_import
   @parsed_file=CSV::Reader.parse(params[:dump][:file])
     n=0
     @parsed_file.each  do |row|
     c=Card.new
     c.head=row[0]
     c.front=row[1]
     c.back=row[2]
     c.user_id=current_user.id
     c.pile_id=(params[:id])
     if c.save
        n=n+1
        GC.start if n%50==0
     end     
     flash.now[:notice]="CSV Import Successful,  #{n} new records added to data base"
     end
     redirect_back_or_default :action => "show", :id => (params[:id])
  end

  def csv_export
   @pile = Pile.find(:first, :conditions => ["id = ?", params[:id]])
   @cards=Card.find(:all, :conditions => ["pile_id = ?", (params[:id]) ])

   pile = StringIO.new

      CSV::Writer.generate(pile, ',') do |title|        
        title << ['Id','head','front', 'back','note']

        @cards.each do |c|

          title << [c.id,c.head,c.front,c.back, c.note]

        end

      end

     pile.rewind

     send_data(pile.read,:type=>'text/csv;charset=iso-8859-1;
     header=present',:filename=> @pile.category.name + '-' +@pile.name,

     :disposition =>'attachment', :encoding => 'utf8')

  end

  def feed
    @latest_pile = Pile.find(:all, :order => "created_at DESC", :limit => 30)
    @popular_pile = Pile.popular(30)
    respond_to do |format|
        format.xml  { render :xml => @latest_pile }
        format.json  { render :json => @latest_pile }
        format.rss  { render :layout => false }
        #format.atom  { render :layout => false }
      end
  end 

  protected

  


end
