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
    @inventory = Inventory.create!(inventory_params)

    redirect_to :back
  end

  def update
    Inventory.find(params[:id]).update_attributes(inventory_params)

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
