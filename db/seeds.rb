# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pokemon_seed_data = JSON.parse(File.read('db/pokemon_seed_data.json'))
pokemon_seed_data.each do |pokemon|
  Pokemon.create(name: pokemon)
end
