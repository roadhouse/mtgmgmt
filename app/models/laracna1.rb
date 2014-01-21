require 'nokogiri'
require 'open-uri'

class Laracna1
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

class Crawler1
  # http://www.mtgdecks.net/decks/viewByFormat/27/page:9
  SOURCE = "http://www.mtgdecks.net"
  DECK_LIST_URL = "#{SOURCE}/decks/viewByFormat/27/"

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(SOURCE + @url))
    p "DECK URL: #{@url}"
  end

  def self.list_deck(list_url)
    doc = Nokogiri::HTML(open(list_url))
    doc.search("tr strong a").map {|node| node.attribute("href").value};
  end

  def fix_typos(string)
    string
      .gsub(/\t/," ")
      .gsub(/''/,"'") 
      .strip
  end

  def deck
    main = @doc.search(".type li").text.strip.split("\t\n").map {|i| fix_typos i}
    sb = @doc.search(".sb .cardItem").map {|i| fix_typos i.text}
    
    main.append("").append(sb).flatten.join("\r\n")
  end

  def name
    @doc.search(".deckHeader .breadcrumb strong").text
  end

  def description
    @doc.search(".deckHeader div strong").text
  end

  def date
    @doc.search(".rightBlock ul li")[4].text
  end

  def self.extract
    (1..200).each do|page|
      url = DECK_LIST_URL + "page:#{page}"

      list_deck(url).each do |i|
        print "URL:#{url}\n"

        spider = Crawler.new(i)

        params = {card_list: spider.deck, name: spider.name, description: spider.description, url: SOURCE + i, date: spider.date}

        DeckBuilder.new(params).build
      end
    end
  end
end

class Crawler2
  # http://www.decklists.net/index.php?option=com_ohmydeckdb&controller=results&orderdir=desc&view=results&sformat[]=29&Itemid=&page=4&ordering=submitdate
  SOURCE = "http://www.decklists.net"
  DECK_LIST_URL = "#{SOURCE}/index.php?option=com_ohmydeckdb&controller=results&orderdir=desc&view=results&sformat[]=29&Itemid=&ordering=submitdate"

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(SOURCE + @url))
    p "DECK URL: #{@url}"
  end

  def self.list_deck(list_url)
    doc = Nokogiri::HTML(open(list_url))
    doc.search("table tr td a")
      .map {|node| node.attribute("href").text}
      .find_all {|node| node =~ /controller=deck/}
  end

  def deck
    @doc.search(".imagetd").remove
    @doc.search(".title").remove
    @doc.search(".cardCount").remove

    main = @doc.search(".OhMyDecklistTableView tr").last.search("td").first.search("li").map(&:text).map {|i| fix_typos i}
    sb = @doc.search(".OhMyDecklistTableView tr").last.search("td").last.search("li").map(&:text).map {|i| fix_typos i}
    
    main.append("").append(sb).flatten.join("\r\n")
  end

  def fix_typos(text)
    text.gsub(/^(\d*)x/,"\1")
      .gsub("Æ","Ae")
  end

  def name
    @doc.search("h1").first.text
  end

  def description
    @doc.search(".eventInfo").text
  end

  def date
    @doc.search(".OhMyDecklistDate").text.gsub("on ", "")
  end

  def self.extract
    (35..200).each do|page|
      url = DECK_LIST_URL + "&page=#{page}"

      list_deck(url).each do |i|
        print "URL:#{url}\n"

        spider = Crawler2.new(i)

        params = {card_list: spider.deck, name: spider.name, description: spider.description, url: SOURCE + i, date: spider.date}

        DeckBuilder.new(params).build
      end
    end
  end
end
