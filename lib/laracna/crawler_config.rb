class CrawlerConfig
  def initialize(source)
    config_file = File.read("lib/laracna/config.yml")

    @config = YAML.load(config_file).fetch(source.to_s)
  end

  def host 
    @config.fetch("host")
  end

  def deck_list_url 
    @config.fetch("deck_list_url")
  end

  def pagination_param 
    @config.fetch("pagination_param")
  end

  def deck_url 
    @config.fetch("deck_url")
  end

  def complete_deck_url
    host + deck_url
  end

  def list_decks_url(page)
    host + 
    deck_list_url + 
    pagination_param + 
    page.to_s
  end
end
