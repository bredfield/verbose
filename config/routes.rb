Verbose::Application.routes.draw do
  devise_for :users
  get 'words/search' => 'words#search', as: "search_words"

  resources :words

  root :to => "words#index"

end
