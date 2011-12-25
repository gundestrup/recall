class CategoriesController < ApplicationController
  before_filter :login_required , :except => [ :show, :index ]
  #layout  'scaffold'
  
  def index      
      @categories = Category.find(:all)
      respond_to do |format|        
        format.xml  { render :xml => @categories.to_xml(:include => [:piles], :except => :user_id) }
        format.json  { render :json => @categories.to_json(:include => [:piles], :except => :user_id) }      
        format.mobile
      end
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ],
         :redirect_to => { :action => :list }

  def list

    if current_user.admin?
        @categories = Category.paginate :per_page => 10, :page => params[:page],
            :conditions => ["name LIKE ?", "%#{params[:search]}%"]
    else
      redirect_to :controller => account, :action => 'index'
      flash[:notice] = 'Sorry you are not an admin.'
    end
  end

  def show
    @category = Category.find(:first, :conditions => ['id = ?',params[:id]])
      if @category == nil
            redirect_to :controller => "search"
            flash[:notice] = "Error, no categories found"
      end
    session[:cat] = @category
    @data = session[:cat]
    
    @latest_pile = Pile.find(:all, :conditions => ['category_id = ?', params[:id]])
    respond_to do |format|
        format.html
        format.xml  { render :xml => @category.to_xml(:include => {:piles => { :include => [:cards] }}, :except => :user_id) }
        format.json  { render :json => @category.to_json(:include => {:piles => { :include => [:cards] }}, :except => :user_id) }
        format.rss  { render :layout => false }
        #format.atom  { render :layout => false }        
        format.mobile 
      end      

  end

  def new
    if current_user.admin?
        @category = Category.new
    else
        redirect_to :controller => account, :action => 'index'
        flash[:notice] = 'Sorry you are not an admin.'
    end
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit

      if current_user.admin?
        @category = Category.find(params[:id])
    else
      redirect_to :action => 'list'
      flash[:notice] = 'Sorry you are not an admin.'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      redirect_to :action => 'show', :id => @category
    else
      render :action => 'edit'
    end
  end

  def destroy    
      if current_user.admin?
      Category.find(params[:id]).destroy
      redirect_to :action => 'list'
    else
      redirect_to :action => 'list'
      flash[:notice] = 'Sorry you are not an admin.'
    end
  end  
  
end
