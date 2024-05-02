Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  post "/stripe_webhooks", to: "stripe_webhooks#create"
  get "up" => "rails/health#show", as: :rails_health_check
end
