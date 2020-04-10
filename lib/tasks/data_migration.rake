desc "adds populations to the countries. "
task :add_population => :environment do
  Country::POPULATIONS.each_with_index do |entry, index|
    name = entry[:country]
    pop = entry[:pop]
    if nation = Country.find_by_name(name)
      nation.update(population: pop)
      puts "population added to #{name}: #{index}"
    else
      puts "No entry for #{name}: #{index}"
    end
  end
end
