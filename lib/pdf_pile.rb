require 'pdf/writer'

class PdfPile
    PAPER = 'A4'

    require 'iconv'

    def self.replace_UTF8(field)
      ic_ignore = Iconv.new('ISO-8859-15//IGNORE//TRANSLIT', 'UTF-8')
      field = ic_ignore.iconv(field)
      ic_ignore.close

      field
    end

   def self.create(pile)

       pdf = PDF::Writer.new( :paper => PAPER )
       pdf.font_families["Helvetica"] =
            {
                "b" => "Helvetica-Bold",
                "i" => "Helvetica-Oblique",
                "bi" => "Helvetica-BoldOblique",
                "ib" => "Helvetica-BoldOblique"
            }
       pdf.start_page_numbering(550, 20, 10)       
       pile.cards.each do |card|
         pdf.text self.replace_UTF8(pile.category.name + ': ' + pile.name)         
         pdf.text 'Head: ' + self.replace_UTF8(card.head)
         pdf.text 'Front: ' + self.replace_UTF8(card.front)
         pdf.text 'Back: ' + self.replace_UTF8(card.back)
       end

       pdf.render
   end

   

end