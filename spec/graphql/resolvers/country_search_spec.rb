require "rails_helper"

RSpec.describe "CountrySearch" do
  let!(:covid_daily) { create(:covid_daily, total_cases: 30) }
  let(:query) do
    %|
      query countrySearch($name: String) {
        countrySearch(countryName: $name){
          recentUpdate{
            totalCases
          }
        }
      }
    |
  end

  let(:result) { Covid19ApiSchema.execute(query, variables: variables, context: nil) }

  context "looking for all" do
    let(:variables) { { } }
    it "should return all (1) country in the db" do
      data = result.dig("data", "countrySearch")
      expect(data.first.dig("recentUpdate", "totalCases")).to eql 30
    end
  end
end
