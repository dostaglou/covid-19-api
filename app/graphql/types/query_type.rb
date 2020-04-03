module Types
  class QueryType < Types::BaseObject

    field(name: :country_search,
          null: false,
          type: [Types::CountryType],
          resolver: Resolvers::CountrySearch)
  end
end
