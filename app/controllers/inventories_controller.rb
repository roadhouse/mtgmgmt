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
    scope = {
      card_id: inventory_params[:card_id],
      user_id: current_user.id,
      list: inventory_params[:list],
    }

    @inventory = Inventory.find_or_create_by(scope)
    @inventory.copies = inventory_params[:copies]
    @inventory.save!
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
      .joins(:card).merge(Card.order(price: :desc))
  end

  def have
    @inventories = current_user.inventories.where(list: "have")
  end

  private

  def inventory_params
    params.require(:inventory).permit(:copies, :card_id, :list)
  end
end
