class BggImportsController < ApplicationController
  def create
    bgg_username = params[:bgg_import][:bgg_username]
    if bgg_username
      current_user.update(bgg_username: bgg_username)
      Delayed::Job.enqueue BggImporterJob.new(current_user)
      redirect_to dashboard_path
    end
  end
end
