xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Piles"
    xml.description "Newest piles"
    xml.link formatted_articles_url(:rss)

    for pile in @latest_pile
      xml.item do
        xml.title pile.head
        xml.description pile.head

      end
    end
  end
end