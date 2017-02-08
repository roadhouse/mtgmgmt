module Utils
  refine Array do
    def delete_first(item)
      delete_at(index(item) || length)
    end

    def missing_itens(deck)
      deck.tap { |d| each { |card| d.delete_first card } }
    end
  end

  refine Hash do
    def expand_list_to_array
      flat_map { |key, value| Array.new(value) { Card.find_by(name: key).id } }
    end
  end
end

