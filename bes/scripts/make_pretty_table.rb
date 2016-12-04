require 'rexml/document'
require 'rexml/element'
require 'rexml/xpath'
include REXML

OUTPUT_FORMAT = 'arrows_3';

TEXT = {
        'nonsig'          => 'Not Significant',
        'positive_strong' => 'Strong Pos', 
        'positive_med'    => 'Pos',
        'positive_weak'   => 'Mild Pos',
        'negative_strong' => 'Strong Neg ',
        'negative_med'    => 'Neg',
        'negative_weak'   => 'Mild Neg'}
        
ARROWS_3 = { #  see https://en.wikipedia.org/wiki/Arrow_(symbol)
        'nonsig'          => '&#x25CF;',
        'positive_strong' => '&#x21c8;', 
        'positive_med'    => '&#x2191;',
        'positive_weak'   => '&#x21e1;',
        'negative_strong' => '&#x21ca;',
        'negative_med'    => '&#x2193;',
        'negative_weak'   => '&#x21e3;'}

ARROWS_2 = { #  see https://en.wikipedia.org/wiki/Arrow_(symbol)
        'nonsig'          => '&#x25CF;',
        'positive_strong' => '&#x21e7;', 
        'positive_med'    => '&#x2191;',
        'positive_weak'   => '&#x21e3;',
        'negative_strong' => '&#x21e9;',
        'negative_med'    => '&#x2193;',
        'negative_weak'   => '&#x21e1;'}

ARROWS_1 = { #  see https://en.wikipedia.org/wiki/Arrow_(symbol) Don't work on Windows Unicode 9
        'nonsig'          => '&#x25CF;',
        'positive_strong' => '&#x1F881;', 
        'positive_med'    => '&#x1F871;',
        'positive_weak'   => '&#x1F861;',
        'negative_strong' => '&#x1F883;',
        'negative_med'    => '&#x1F873;',
        'negative_weak'   => '&#x1F863;' }
        
        
CIRCLES = { 
        'nonsig'          => '&#x25CF;',
        'positive_strong' => '&#x25CF;', 
        'positive_med'    => '&#x25CF;',
        'positive_weak'   => '&#x25CF;',
        'negative_strong' => '&#x25CF;',
        'negative_med'    => '&#x25CF;',
        'negative_weak'   => '&#x25CF;' }
        
MARKS = { 'text'     => TEXT, 
          'arrows_2' => ARROWS_2, 
          'arrows_1' =>ARROWS_1, 
          'arrows_3' =>ARROWS_3,
          'circles'  =>CIRCLES }        
        
def makeCell( number, stars )
        cell = REXML::Element.new( "td" )
        if number == ''
                cell.add_text( '' )     
                return cell
        end
        isNegative = number[0] == '-'
        cellClass = if isNegative then 'negative' else 'positive' end
        case stars
        when "***"
               cellClass += "_strong"
        when "**"
               cellClass += "_med"
        when "*"
               cellClass += "_weak"
        else
               cellClass = 'nonsig'        
        end
        mark = MARKS[ OUTPUT_FORMAT ][ cellClass ]
        cell.add_text( mark )
        cell.add_attribute( 'class', cellClass );
        return cell
end

dfile = File.new( "/home/graham_s/VirtualWorlds/projects/scotland/BES/outputs/t1" )
dict = REXML::Document.new( dfile )
dfile.close()

row = 0
newTable = REXML::Element.new( "table" )
newTable.add_attribute( "class", "easytable" )
tbody = REXML::Element.new( "tbody" )
thead = REXML::Element.new( "thead" )
XPath.each( dict, "//table/tr" ){
        |tr|
        row += 1
        # p table
        newRow = REXML::Element.new( "tr" )
        if ( row <= 6 ) then
                XPath.each( tr, "td" ){
                        |td|
                        newTH = REXML::Element.new( "td" )
                        colspan = td.attribute( "colspan" )
                        style = td.attribute( "style" )
                        newTH.add_attribute( "class", "col_header" )
                        newTH.add_attribute( "style", style )
                        newTH.add_attribute( "colspan", colspan ) if not colspan.nil? 
                        text = td.get_text()
                        text = '' if text.nil?
                        newTH.add_text( text )
                        newRow.add_element( newTH )        
                }
                thead.add_element( newRow )               
        else
                if ( row % 2 ) == 0 then
                        col = 0
                        XPath.each( tr, "td" ){
                               |cell|
                               col += 1
                               # number = c
                               if col == 1 then
                                       newCell = REXML::Element.new( "th" )
                                       text = cell.text()
                                       newCell.add_text( text )  
                                       newCell.add_attribute( "class", "row_header" )
                               else
                                       text = cell.text()
                                       number = if text.nil? then "" else text.strip() end
                                       stars = ''
                                       XPath.each( cell, "sup" ).each{
                                               |sup|
                                               stars = sup.text()
                                       }
                                       newCell = makeCell( number, stars )
                               end
                               # puts "new cell #{newCell}"                                       
                               newRow.add_element( newCell )
                        }
                        tbody.add_element( newRow )
                end
        end
        
}

newTable.add_element( thead )
newTable.add_element( tbody )

formatter = REXML::Formatters::Pretty.new( 0 )
formatter.compact = true
s = ''
formatter.write( newTable, s ) 
s.gsub!( "&amp;", "&" )
puts( s )
# s = "#{newTable}"
# s = s.gsub( "&amp;", "&" )
# s