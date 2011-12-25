class SitemapController < ApplicationController
  layout false
  def sitemap
      @entries = Pile.find(:all, :order => "updated_at DESC", :limit => 50000)
      @entries_card = Card.find(:all, :order => "updated_at DESC", :limit => 50000)
      @entries_category = Category.find(:all, :order => "name", :limit => 500)
      headers["Content-Type"] = "text/xml"
      # set last modified header to the date of the latest entry.
      headers["Last-Modified"] = @entries[0].updated_at.httpdate
    end

end
