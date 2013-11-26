# Parsing strings to format accepted by DeckBuilder class
# order is important, obey the order in Standard class
#
# format supported:
# 4 magmajet
# 20 mountain
# 4 zelatot
# (empty line)
# 3 shock <- sideboard

# dummy class to emulate the format object (not yet implemented)
Standard = OpenStruct.new(parts: [:main, :sideboard])

class DeckListParser
  def initialize(params)
    @params = params.strip
    @format = Standard
  end

  def parse
    @format.parts.inject({}) do |output_hash,part|
      output_hash.tap { |h| h[part] = parse_part(part) }
    end
  end

  def parse_part(part_name)
    index = @format.parts.rindex(part_name)

    #empty line ended in new line character
    part_to_parse = @params.split(/^$\n/)[index]
    
    part_to_parse.split(/\n/).map do |line| 
      quantity, name = line.split(" ")

      {quantity: quantity.strip.to_i, name: name.strip} 
    end
  end
end
