Server::Application.routes.draw do

  resources :notifications, :only => :index

  mount Resque::Server.new, :at => "/resque"
end
