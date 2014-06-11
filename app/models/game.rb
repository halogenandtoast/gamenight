class Game < ActiveRecord::Base

  def self.alphabetical
    order(title: :asc)
  end

end
