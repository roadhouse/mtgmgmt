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
