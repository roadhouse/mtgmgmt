require './lib/laracna/card_crawler'

namespace :crawler do
  desc "download spoiler info"
  task spoilers: :environment do
    spoiler_url = "http://mythicspoiler.com/ogw/index.html"
    default = { set: 'OGW', is_standard: true }

    CardCrawlerPreview.new(spoiler_url)
      .card_list_urls
      .map { |card_url| CardCrawlerPreview.new(spoiler_url).card_attributes("http://mythicspoiler.com/ogw/"+card_url) }
      .map { |crawled_data| p crawled_data; Card.create!(default.merge crawled_data)  }
  end
end

