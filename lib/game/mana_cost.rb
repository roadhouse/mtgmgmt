class Mana
  def initialize(cost)
   @mana_cost = cost 
  end

  def manas
    [].tap do |array|
      @mana_cost.to_s.gsub("{","").gsub("}","").each_char {|i| array << ManaCost.new(i)}
    end
  end

  def colors
    manas.map(&:color)
  end

  def black
    manas.all {|mana| mana.black?}
  end
  
  def red
    manas.all {|mana| mana.red?}
  end

  def blue
    manas.all {|mana| mana.blue?}
  end

  def green
    manas.all {|mana| mana.green?}
  end

  def white
    manas.all {|mana| mana.white?}
  end

  def colorless
    manas.all {|mana| mana.colorless?}
  end

  def converted_manacost
    manas.map(&:value).sum
  end

  def colored?
    manas.map(&:colored?).any? {|mana| mana.colored? == true}
  end

  def colorless?
    manas.map(&:colorless?).all? {|mana| mana.colorless? == true}
  end
end

class ManaCost
  def initialize(mana_cost)
    @mana_cost = mana_cost
  end

  def color
    colors = {"B" => :black, "R" => :red , "U" => :blue, "G" => :green, "W" => :white}
    colors.fetch(mana_color) { :colorless }
  end

  def value
    [1, mana_color.to_i].max
  end

  def colored?
    [black?, red?, blue?, green?, white?].any? {|color| color == true}
  end

  def colorless?
    [black?, red?, blue?, green?, white?].all? {|color| color == false}
  end

  def black?
    mana_color == "B"
  end
  def red?
    mana_color == "R"
  end
  def blue?
    mana_color == "U"
  end
  def green?
    mana_color == "U"
  end
  def white?
    mana_color == "W"
  end

  def colorless?
    mana_color == "X" or !mana_color.to_i.zero? 
  end
  private

  def mana_color
    @mana_cost
  end
end
