require "open-uri"
require "nokogiri"

class CardCrawlerPreview
  def initialize(url)
    @document = Nokogiri::HTML open url
  end

  def card_list_urls
    @document.search("a")
      .find_all { |i| i.attribute("href").text.match("cards") }
      .map { |i| i.attribute("href").text }
  end

  def ar_attributes
    %i(name mana_cost ctype original_text artist power)
  end

  def card_attributes(card_url)
    document = Nokogiri::HTML open card_url

    html_data = document
                .search("center table")[4]
                .search("tr td")
                .map(&:text)
                .map(&:strip)
                .delete_if(&:empty?)
                .delete_if { |i| i.match(/html/) }[1..-1]

    Hash[ar_attributes.zip html_data]
  end
end
