class CollectionsController < ApplicationController
  def create
    @collection = Collection.find_or_create_by(user_id: collection_params[:user_id], name: collection_params[:list]) do |collection|
    end

    card = Card.find(collection_params[:card_id].to_i)
    list = { 
      card.name => { 
        total: collection_params[:copies].to_i,
        card.printings.last => { normal: collection_params[:copies].to_i }
      }
    }

    @collection.list = @collection.list.to_h.merge!(list)
    @collection.save!

    redirect_to :back
  end

  def update
    @collection = Collection.find_or_create_by(user_id: collection_params[:user_id], name: collection_params[:list]) do |collection|
    end

    card = Card.find(collection_params[:card_id].to_i)
    list = { 
      card.name => { 
        total: collection_params[:copies].to_i,
        card.printings.last => { normal: collection_params[:copies].to_i }
      }
    }

    @collection.list = @collection.list.to_h.merge!(list)
    @collection.save!

    redirect_to :back
  end

  private

  def collection_params
    params.require(:collection).permit(:user_id, :copies, :card_id, :list)
  end
end
