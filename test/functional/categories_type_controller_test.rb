require File.dirname(__FILE__) + '/../test_helper'
require 'categories_type_controller'

# Re-raise errors caught by the controller.
class CategoriesTypeController; def rescue_action(e) raise e end; end

class CategoriesTypeControllerTest < ActionController::TestCase
  fixtures :categories_types

  def setup
    @controller = CategoriesTypeController.new
    request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = categories_types(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:categories_types)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:categories_type)
    assert assigns(:categories_type).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:categories_type)
  end

  def test_create
    num_categories_types = CategoriesType.count

    post :create, :categories_type => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_categories_types + 1, CategoriesType.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:categories_type)
    assert assigns(:categories_type).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      CategoriesType.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CategoriesType.find(@first_id)
    }
  end
end
