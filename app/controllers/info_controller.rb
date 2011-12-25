class InfoController < ApplicationController
  def index
    @latest_pile = Pile.find(:all, :order => "created_at DESC", :limit => 5)
    @popular_pile = Pile.popular(5)
  end

  def getting_started
  end

  def help
  end

  def about
  end

  def history

  end

  def statistics
    @total_piles = Pile.count(:all)
    @total_cards = Card.count(:all)
    @total_users = User.count(:all)
    @total_categories = Category.count(:all)
    @latest_pile = Pile.find(:all, :order => "created_at DESC", :limit => 5)
    @popular_pile = Pile.popular(5)
    @latest_card = Card.find(:all, :order => "created_at DESC", :limit => 5)
    @updated_card = Card.find(:all, :order => "updated_at DESC", :limit => 5)
  end

  def error404
    @referer = request.env["HTTP_REFERER"]
  end

end
