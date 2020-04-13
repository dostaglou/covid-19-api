Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  post '/callback', to: 'line_bot#callback'
  post '/callback_twitter', to: 'twitter_bot#callback'
  get '/', to: 'main_page#page'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
