class Pile < ActiveRecord::Base
  has_many :cards,
  :order     =>'position, id',
  :dependent => :destroy

  
  belongs_to :category
  belongs_to :user
  
  validates_presence_of :name


    def self.popular(limit)
        find(:all, :order => "popularity DESC, created_at", :limit => limit)
    end
end
