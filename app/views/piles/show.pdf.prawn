#Page size A6: 297.64 x 419.53
@pile.cards.each do |card|
    pdf.text "#{@pile.category.name}" + ': ' + "#{@pile.name}"
    pdf.text "#{card.head}"

    pdf.text_box "#{card.front}",
    :width => 190, :height => 200,
    :overflow => :truncate,
    :at => [0,200]
	
	pdf.text_box "#{card.back}",
    :width => 190, :height => 200,
    :overflow => :truncate,
    :at => [205, 200]

    pdf.stroke_line [200,0], [200,200]
#

#	pdf.bounding_box([10,20], :width => 100, :height => 200) do
#    	pdf.text "This text will flow in a very narrow box starting" +
#     	"from [100,500]. The pointer will then be moved to [100,200]" +
#     	"and return to the margin_box"
#	end
    pdf.start_new_page
end