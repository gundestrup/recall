require File.dirname(__FILE__) + '/../test_helper'

class CardTest < ActiveRecord::TestCase
  fixtures :cards

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  test "invalid with empty attributes" do
    card = Card.new
    assert !card.valid?
    assert card.errors.invalid?(:front)
    assert card.errors.invalid?(:back)
    assert card.errors.invalid?(:user_id)
    assert card.errors.invalid?(:pile_id)
  end

end
