class CardsController < ApplicationController
    before_filter :login_required, :except =>  [ :show, :index ]

   
  uses_tiny_mce(:options => {:theme => 'advanced',
                           :browsers => %w{msie gecko},
                           :theme_advanced_toolbar_location => "top",
                           :theme_advanced_toolbar_align => "left",
                           :theme_advanced_resizing => true,
                           :theme_advanced_resize_horizontal => false,
                           :paste_auto_cleanup_on_paste => true,
                           :theme_advanced_buttons1 => %w{bold italic underline strikethrough separator justifyleft justifycenter justifyright indent outdent separator bullist numlist forecolor backcolor separator link unlink undo redo},
                           :theme_advanced_buttons2 => %w[formatselect fontselect fontsizeselect],
                           :theme_advanced_buttons3 => [],
                           :plugins => %w{contextmenu paste}},
              :only => [:new, :edit])
  
  def index

         @cards = Card.paginate :per_page => 10, :page => params[:page],
                             :conditions => ["head LIKE ? OR front LIKE ? OR back LIKE?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"]
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ],
         :redirect_back_or_default => { :action => :list }

  def show
    @card = Card.find(:first, :conditions => ['id = ?', params[:id]])
      if @card == nil
          redirect_to :controller => "search"
            flash[:notice] = "Error, no cards found"
      end
      respond_to do |format|
            format.html
            format.xml  { render :xml => @card.to_xml(:include => {:pile => { :include => [:category] }}, :except => :user_id) }
            format.json  { render :json => @card.to_xml(:include => {:pile => { :include => [:category] }}, :except => :user_id) }            
    end
  end
  
  def new
    @card = Card.new
    @pile = session[:pil]
  end

  def create
    @card = Card.new(params[:card])
    if @card.head.length < 1
      @card.head = @card.front
    end
    
    @card.pile_id = session[:pil].id
    @card.user_id=current_user.id
    @pile = session[:pil]
    if @card.save
      flash[:notice] = 'Card was successfully created.'
      #redirect_back :controller => 'piles'
      @id = session[:pil]
      redirect_back_or_default :controller => "piles", :action => 'show', :id => session[:pil].id
    else
      render :action => 'new'
    end
  end

  def edit
    @pile = session[:pil]
    @card = Card.find(params[:id])
    if @card.pile.user_id == current_user.id or current_user.admin?
    else
    	redirect_back_or_default :controller => "/info"
      flash[:notice] = 'Sorry, you can\'t edit other peoples cards'
      
    end
  end

  def update
    @card = Card.find(params[:id])
    @card.pile_id = session[:pil].id
    @card.user_id=current_user.id
    if @card.update_attributes(params[:card])
      flash[:notice] = 'Card was successfully updated.'
      redirect_back_or_default  :controller => "piles", :action => 'show', :id => session[:pil].id
    else
      render :action => 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.pile_id = session[:pil].id
    if @card.pile.user_id == current_user.id or current_user.admin?
    @card.destroy
    redirect_back_or_default  :controller => "piles", :action => 'show', :id => session[:pil].id
    flash[:notice] = 'Card deleted'
    else
      flash[:notice] = 'Sorry, you can\'t delete other peoples cards'
      redirect_back
    end
  end
end
