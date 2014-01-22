class BoxedGame < ActiveRecord::Base
  belongs_to :box
  belongs_to :game
end
