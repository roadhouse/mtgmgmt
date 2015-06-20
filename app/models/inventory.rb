class Inventory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :card
  belongs_to :user

  def collection_to_hash(collection)
    Inventory.where(list: collection).each_with_object({}) do |v,m| 
      m[v.card.name] = {
        "total"=> v.copies, 
        v.card.printings.last => {
          "normal" => v.copies
        }
      }
    end
  end
end
