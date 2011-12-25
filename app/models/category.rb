class Category < ActiveRecord::Base
  has_many :piles
  belongs_to :categories_type
  validates_associated :categories_type
    
end
