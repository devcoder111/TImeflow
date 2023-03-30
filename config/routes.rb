# == Route Map
#

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :simulation_steps

  resources :report_items

  get '/event_definitions/:id', to: 'simulations#event_definitions', as: 'event_definitions'
  get '/event_definition_monitor/:id', to: 'time_flow_monitors#event_definitions', as: 'event_definition_monitor'

  resources :projects do
    resources :simulations do
      member do
        get :start
        get :pause
      end
    end
    resources :reports do
      collection do
        get :event_stream_fields
      end
    end
    resources :time_flow_logs
    resources :event_stream_fields
    resources :event_streams do
      collection do
        get :saved_search
        get :external_data_sources
        get :simulations_workflow
        get :time_series
        get :metrics_workflow
      end
    end
    resources :alerts
    resources :time_flow_monitors, path: 'monitors' do
      member do
        get :start
        get :pause
        get :preview
      end

      collection do
        get :preview
      end
    end
    resources :splashes
    resources :datas do
      collection do
        post :set_event_stream
        post :search_results
      end
    end
  end

  devise_for :users
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
