require File.dirname(__FILE__) + '/../test_helper'
require 'cards_controller'

# Re-raise errors caught by the controller.
class CardsController; def rescue_action(e) raise e end; end

class CardsControllerTest < Test::Unit::TestCase
  fixtures :cards

  def setup
    @controller = CardsController.new
    request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = cards(:first).id
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

    assert_not_nil assigns(:cards)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:card)
    assert assigns(:card).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:card)
  end

  def test_create
    num_cards = Card.count

    post :create, :card => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_cards + 1, Card.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:card)
    assert assigns(:card).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Card.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Card.find(@first_id)
    }
  end
end
