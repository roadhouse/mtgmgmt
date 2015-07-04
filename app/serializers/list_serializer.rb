class ListSerializer
  def self.dump(hash)
    hash
      .each_with_object({}) { |part, list| list[part.first] = array_to_hash(part.last) }
      .to_json 
  end

  def self.load(hash)
    hash.to_h
      .each_with_object({}) { |part, list| list[part.first] = hash_to_array(part.last) }
      .with_indifferent_access
  end

  def self.array_to_hash(list)
    quantities = list.map { |card| [card.name, list.count { |current| current.name == card.name }] }

    Hash[quantities]
  end

  # {"name" => 2} -> [<Card name: "name">, <Card name: "name"> ]
  def self.hash_to_array(list)
    list.flat_map do |entry|
      card_name, copies = entry
      
      Array.new(copies.to_i) { |_| Card.find_or_initialize_by(name: card_name)}
    end
  end
end
