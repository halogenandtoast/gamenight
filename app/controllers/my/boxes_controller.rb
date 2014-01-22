class My::BoxesController < ApplicationController
  def show
    @box = current_user.boxes.find(params[:id])
  end

  def destroy
    current_user.boxes.find(params[:id]).destroy
    redirect_to dashboard_path
  end
end
