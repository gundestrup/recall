class Card < ActiveRecord::Base
  belongs_to :pile
  belongs_to :user

  acts_as_list
  
  validates_presence_of :front, :back, :user_id, :pile_id
    
end
