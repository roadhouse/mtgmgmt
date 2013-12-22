require 'nokogiri'
require 'open-uri'

class Laracna
  SOURCE = "http://letscollect.com.br/ecom.aspx/Produto/"

  def initialize(name, set)
    @name = name
    @set = set
  end

  def prices
    doc = Nokogiri::HTML(open(SOURCE + slug_name))
    doc.search("#ctl00_content_rptVariacoes_ctl00_pnlVariacaoParcelamento").remove
    doc.search(".variacaoPreco").text.strip
  end

  def slug_name(name = @name)
    name.downcase.gsub('\'','').gsub(' ','_') + "_#{@set}"
  end
end

class Crawler
  # http://www.mtgdecks.net/decks/viewByFormat/27/page:9
  SOURCE = "http://www.mtgdecks.net"
  DECK_LIST_URL = "#{SOURCE}/decks/viewByFormat/27"

  def list_deck
    doc = Nokogiri::HTML(open(DECK_LIST_URL))
    doc.search("tr strong a").map {|node| node.attribute("href").value};
  end

  def deck(url)
    doc = Nokogiri::HTML(open(SOURCE + url))
    main = doc.search(".type li").text.strip.split("\t\n").map {|i| fix_typos i}
    sb = doc.search(".sb .cardItem").map {|i| fix_typos i.text}
    
    main.append("").append(sb).flatten.join("\r\n")
  end

  def fix_typos(string)
    string
    .gsub(/\t/," ")
    .gsub(/''/,"'") 
    .strip
  end

  def name(url)
    doc = Nokogiri::HTML(open(SOURCE + url))

    doc.search(".deckHeader .breadcrumb strong").text
  end

  def description(url)
    doc = Nokogiri::HTML(open(SOURCE + url))

    doc.search(".deckHeader div strong").text
  end
  

  def extract
    list_deck.each do |i|
      print "URL:#{i}\n"

      params = {card_list: deck(i), name: name(i), description: description(i)}

      DeckBuilder.new(params).build
    end
  end
end
