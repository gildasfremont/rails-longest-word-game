Rails.application.routes.draw do
  get 'play', to: 'game#play'

  get 'score', to: 'game#score'

  get 'game_controller/play'

  get 'game_controller/score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
