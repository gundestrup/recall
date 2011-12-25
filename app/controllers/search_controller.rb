class SearchController < ApplicationController
     def index
        items_per_page = 10

    sort = case params['sort']
           when "name"  then "name"
           when "name_reverse"  then "name DESC"
           end


    conditions = ["categories.name LIKE ? OR piles.name LIKE ? OR cards.head LIKE ? OR cards.front LIKE ? OR cards.back LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"]

      @categories = Category.paginate :per_page => items_per_page, :page => params[:page],
                                      :conditions => conditions,
                                      :order => sort,
                                      :include => [:piles, {:piles => :cards}]
    end
     
end
