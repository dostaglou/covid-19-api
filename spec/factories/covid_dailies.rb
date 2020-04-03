FactoryBot.define do
  factory :covid_daily do
    association :country, factory: :country
    country_name {"country-name"}
    total_cases {10}
    today_cases {5}
    total_deaths {3}
    today_deaths {1}
    active {3}
    recovered {4}
    critical {1}
    case_per_million {14.2}
    death_per_million {4.7}
    updated {1585744555711}
  end
end
