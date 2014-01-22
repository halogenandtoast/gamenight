class My::MergesController < ApplicationController
  respond_to :json

  def create
    box = current_user.boxes.find(params[:id])
    box_to_merge = current_user.boxes.find(params[:box_id])
    box.game_ids += box_to_merge.game_ids
    box_to_merge.destroy
    if box.save
      render json: { success: true }, status: 200
    else
      render json: { success: false }, status: 422
    end
  end
end
