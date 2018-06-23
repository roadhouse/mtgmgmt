class InventoriesController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    scope = {
      card_id: inventory_params[:card_id],
      user_id: current_user.id,
      list: inventory_params[:list],
    }

    @inventory = Inventory.find_or_create_by(scope)
    @inventory.copies = @inventory.copies.to_i + inventory_params[:copies].to_i
    @inventory.save!
  end

  private

  def inventory_params
    params.require(:inventory).permit(:copies, :card_id, :list)
  end
end
