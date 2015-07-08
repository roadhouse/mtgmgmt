class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all

    respond_with(@inventories)
  end

  def show
    @inventory = Inventory.find(params[:id])

    respond_with(@inventory)
  end

  def new
    @inventory = Inventory.new

    respond_with(@inventory)
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def create
    # TODO: move this to serializer/whatever remove from here
    @collection = Collection.find_or_create_by(user_id: inventory_params[:user_id], name: inventory_params[:list]) do |collection|
    end

    card = Card.find(inventory_params[:card_id].to_i)
    list = { 
      card.name => { 
        total: inventory_params[:copies].to_i,
        card.printings.last => { normal: inventory_params[:copies].to_i }
      }
    }

    @collection.list = @collection.list.to_h.merge!(list)
    @collection.save!

    @inventory = Inventory.create!(inventory_params)

    redirect_to :back
  end

  def update
    #TODO messy and transitional code, remove Inventory soon
    Inventory.find(params[:id]).update_attributes(inventory_params)
    @collection = Collection.find_or_create_by(user_id: inventory_params[:user_id], name: inventory_params[:list]) do |collection|
    end

    card = Card.find(inventory_params[:card_id].to_i)
    list = { 
      card.name => { 
        total: inventory_params[:copies].to_i,
        card.printings.last => { normal: inventory_params[:copies].to_i }
      }
    }

    @collection.list = @collection.list.to_h.merge!(list)
    @collection.save!

    redirect_to :back
  end

  def destroy
    @inventory = Inventory.find(params[:id])

    respond_with(@inventory.destroy)
  end

  def want
    @inventories = current_user.inventories.where("copies < 4").where(list: "game")
  end

  def have
    @inventories = current_user.inventories.where(list: "have")
  end

  private

  def inventory_params
    params.require(:inventory).permit(:user_id, :copies, :card_id, :list)
  end
end
