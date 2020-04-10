class CovidDaily < ApplicationRecord
  belongs_to :country

  scope :most_recent, -> (x = 1) do
                                  value = order(created_at: :desc).limit(x)
                                  value = value.first if x == 1
                                  value
                                 end

  def mortality_rate
    self.total_deaths / self.total_cases.to_f * 100
  end

  def recovery_rate
    self.recovered / self.total_cases.to_f * 100
  end
end
