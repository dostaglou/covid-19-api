Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  root to: 'countries#random'

  get '/countries/:name', to: 'countries#show', as: 'country'

  get '/regions/:name', to: 'countries#region', as: 'region'

  post '/graphql', to: 'graphql#execute'

  post '/callback', to: 'line_bot#callback'

  post '/callback_twitter', to: 'twitter_bot#callback'
end
