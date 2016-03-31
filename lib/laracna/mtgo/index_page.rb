require "nokogiri"
require "open-uri"

module Laracna
  module Mtgo
    class IndexPage
      def initialize(page); end

      def urls
        (8.months.ago.to_date..DateTime.now.to_date).to_a.reverse.map do |date|
          formated_date = date.strftime("%Y-%m-%d")
          "http://magic.wizards.com/en/articles/archive/mtgo-standings/standard-daily-#{formated_date}"
        end
      end
    end
  end
end
