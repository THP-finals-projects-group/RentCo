# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

p " ********************************* "
p " *                               * "
p " *         BEGIN OF SEED         * "
p " *                               * "
p " ********************************* "

# p "Destroy curent data..."
# p "Destroying Cases... #{Case.count} "
# Case.destroy_all
# p "Destroying Users... #{User.count} "
# User.destroy_all
# p "-----------------------"
# p "-----------------------"

professions = ["Chasseur de bien", "Agent Immobilier", "Notaire"]
types = ["T1", "T2", "T3", "T4"]
projects = ["Maison", "Appartement", "Local commercial"]
def generate_quote_sv
  quote = ""
  while quote.length < 26 || quote.length >= 500
    quote = Faker::TvShows::SiliconValley.quote
  end
  quote
end
def generate_quote_vfv
  quote = ""
  while quote.length < 26 || quote.length >= 500
    quote = Faker::Movies::VForVendetta.quote
  end
  quote
end
def generate_quote_s
  quote = ""
  while quote.length < 26 || quote.length >= 500
    quote = Faker::TvShows::Suits.quote
  end
  quote
end

# PASS ONLY VALIDATIONS
p "-----------------------"
p "Validation Only passed ?"
User.create!(
  firstname: "AllValid",
  lastname: "IPassed",
  email: "validation@yopmail.com",
  password: "password",
  phone_number: "0639629030",
  profession: professions[rand(0..(professions.length - 1))]
).cases.new(
  title: "#{Faker::Address.community} - ValidTest",
  visit_date: Faker::Date.between(from: 5.days.ago, to: Date.today),
  case_reference: "Matthieu Gillet",
  street_number: Faker::Address.building_number,
  street_name: Faker::Address.street_name,
  city: Faker::Address.city,
  zipcode: "50400",
  contact_referent: "Matthieu Gillet Matthieu Gillet Matthieu Gillet Matthieu Gillet",
  old_surface: rand(8..150),
  old_rooms_count: rand(1..10),
  old_type: types[rand(0..types.length - 1)],
  old_project: projects[rand(0..projects.length - 1)] 
).rooms.new(rent_monthly: 0).save
p "Yes"
p "-----------------------"

# Users
users = []
5.times do |n|
  names = Faker::TvShows::Suits.character.split(" ")
  users[n] = User.create!(
    firstname: names[0],
    lastname: names[1],
    email: "#{names[0]}.#{names[1]}0#{n}@yopmail.com",
    password: "#{names[0]}#{names[1]}",
    phone_number: "075043905#{n}",
    profession: professions[rand(0..(professions.length - 1))]
  )
end
p "#{tp User.all}"
p "Creation Users... #{User.count}"
p "DONE"
p "-----------------------"
p "-----------------------"

# Cases
users.each do |user|
  5.times do |n|
    casen = user.cases.new(
      title: "#{Faker::Address.community} - 42#{n}",
      visit_date: Faker::Date.between(from: 20.days.ago, to: Date.today),
      case_reference: "Matthieu Gillet",
      street_number: Faker::Address.building_number,
      street_name: Faker::Address.street_name,
      city: Faker::Address.city,
      zipcode: "5040#{n}",
      is_confirmed: false,
      physical_description: generate_quote_sv,
      geographical_description: generate_quote_vfv,
      potential_description: generate_quote_s,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      contact_referent: "Matthieu Gillet Matthieu Gillet Matthieu Gillet Matthieu Gillet",
      old_surface: rand(8..150),
      old_rooms_count: rand(1..10),
      old_type: types[rand(0..types.length - 1)],
      old_project: projects[rand(0..projects.length - 1)],
      water_cost: rand(10..50),
      heater_cost: rand(10..50),
      electricity_cost: rand(10..50),
      union_charges_cost: rand(10..50),
      common_charges_cost: rand(10..50),
      seller_price: rand(20000..1000000),
      estimated_negociation: rand(500..10000),
      notary_charges: rand(500..10000),
      property_taxes: rand(500..5000),
      agency_charges: rand(500..5000),
      renovation_union: rand(0..5000),
      renovation_demolition_cost: rand(0..500),
      renovation_preparation_cost: rand(0..500),
      renovation_carpentry_cost: rand(0..500),
      renovation_plastering_cost: rand(0..500),
      renovation_electricity_cost: rand(0..500),
      renovation_plumbing_cost: rand(0..500),
      renovation_wall_ceiling_cost: rand(0..500),
      renovation_painting_cost: rand(0..500),
      renovation_flooring_cost: rand(0..500),
      renovation_kitchen_cost: rand(0..500),
      renovation_furniture_cost: rand(0..500),
      renovation_facade_cost: rand(0..500),
      renovation_security_cost: rand(0..500),
      renovation_masonry_cost: rand(0..500),
      renovation_covering_cost: rand(0..500),
      month_count: rand(1..12),
      new_surface: rand(8..150),
      new_rooms_count: rand(1..10),
      new_type: types[rand(0..types.length - 1)],
      new_project: projects[rand(0..projects.length - 1)],
    )
    casen.new_rooms_count.times do
      casen.rooms.new(rent_monthly: rand(150..500))
    end
    casen.save
  end
end

p "#{tp Case.all}"
p "Creation Cases... #{Case.count}"
p "DONE"
p "-----------------------"
p "-----------------------"
p " ********************************* "
p " *                               * "
p " *          END OF SEED          * "
p " *                               * "
p " ********************************* "
