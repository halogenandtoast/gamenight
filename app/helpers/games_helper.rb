module GamesHelper
  def know_button(game)
    if current_user.knows?(game)
      link_to know_game_path(game), method: :delete do
        fa_icon "lightbulb-o", class: 'know active'
      end
    else
      link_to know_game_path(game), method: :post do
        fa_icon("lightbulb-o", class: 'know')
      end
    end
  end
end
