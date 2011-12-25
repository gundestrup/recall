atom_feed do |feed|
  feed.title "ReCALL-Because you can"
  feed.updated((@latest_pile.first.created_at))
  
  for pile in @latest_pile  
    feed.entry(pile) do |entry|
      entry.title(pile.name)
      entry.content(pile.category.name, :type => 'html')
      entry.author do |author|
        author.name("Svend Gundestrup")
      end
      entry.link url_for(:only_path => false,
                        :controler => 'piles',
                        :action => 'show',
                        :id => pile.id)
    end
  end
end
