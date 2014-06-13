class BggImporterJob
  def initialize(user)
    @user = user
  end

  def perform
    BggImporter.new(user).import
  end

  private
  attr_reader :user
end
