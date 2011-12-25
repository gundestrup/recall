xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "ReCALL"
    xml.description "Because you can"
    xml.link url_for(:only_path => false,
                     #:controler => 'piles',
                     :action => 'show')

    for pile in @latest_pile
      xml.item do
          xml.title pile.category.name
          xml.description pile.name
          xml.pubDate pile.created_at.to_s(:rfc822)
          xml.link url_for(:only_path => false,
                            #:controler => 'piles',
                            :action => 'show',
                            :id => pile.id)
        end
    end
  end
end
