class CategoriesTypeController < ApplicationController
  before_filter :login_required, :except =>  [ :show ]  
  #before_filter :not_logged_in_required, :only => [ :show ]
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ],
         :redirect_to => { :action => :list }

  def list

    if current_user.admin?
    @categories_types = CategoriesType.paginate :per_page => 10, :page => params[:page],
            :conditions => ["category_type LIKE ?", "%#{params[:search]}%"]
    else
        redirect_to :controller => "accounts", :action => 'index'
        flash[:notice] = 'Sorry you are not an admin.'
     end
  end

  def show
    @categories_type = CategoriesType.find(params[:id])
  end

  def new
      if current_user.admin?
        @categories_type = CategoriesType.new
      else
        redirect_to :action => 'list'
        flash[:notice] = 'Sorry you are not an admin.'
    end
  end

  def create
    @categories_type = CategoriesType.new(params[:categories_type])
    @categories_type.user_id=current_user.id
    if @categories_type.save
      flash[:notice] = 'CategoriesType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit

      if current_user.admin?
        @categories_type = CategoriesType.find(params[:id])
      else
        redirect_to :action => 'list'
        flash[:notice] = 'Sorry you are not an admin.'
      end
  end

  def update
    @categories_type = CategoriesType.find(params[:id])
    if @categories_type.update_attributes(params[:categories_type])
      flash[:notice] = 'CategoriesType was successfully updated.'
      redirect_to :action => 'show', :id => @categories_type
    else
      render :action => 'edit'
    end
  end

  def destroy    
      if current_user.admin?
        CategoriesType.find(params[:id]).destroy
      redirect_to :action => 'list'
      else
        redirect_to :action => 'list'
        flash[:notice] = 'Sorry you are not an admin.'
      end
  end
end
