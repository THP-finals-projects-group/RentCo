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

# p "Destroying Product... #{Product.count} "
# Product.destroy_all
# p "-----------------------"
# p "-----------------------"


# Users
users = []
5.times do |n|
  names = Faker::TvShows::Suits.character.split(" ")
  users[n] = User.create!(
    firstname: names[0],
    lastname: names[1],
    email: "#{names[0]}.#{names[1]}0#{n}@yopmail.com",
    password: "#{names[0]}#{names[1]}",
    phone_number: "0750439050#{n}"
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
    user.cases.create!(
      title: "#{Faker::Address.community} - 42#{n}",
      visit_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
      case_reference: "Matthieu Gillet",
      street_number: Faker::Address.building_number,
      street_name: Faker::Address.street_name,
      city: Faker::Address.city,
      zipcode: "5040#{n}",
      contact_referent: "Matt"
    )
  end
end
p "#{tp Case.all}"
p "Creation Cases... #{Case.count}"
p "DONE"
p "-----------------------"
p "-----------------------"

# types & projects
types = ["T1", "T2", "T3", "T4"]
projects = ["Maison", "Appartement", "Local commercial"]

types.each do |type|
  Type.create!(name: type)
end
projects.each do |projet|
  Project.create!(name: projet)
end

p "#{tp Type.all}"
p "Creation Type... #{Type.count}"
p "#{tp Project.all}"
p "Creation Project... #{Project.count}"
p "DONE"
p "-----------------------"
p "-----------------------"

# renovations
25.times do |n|
  Renovation.create!(
    demolition_cost: rand(0..500),
    preparation_cost: rand(0..500),
    carpentry_cost: rand(0..500),
    plastering_cost: rand(0..500),
    electricity_cost: rand(0..500),
    plumbing_cost: rand(0..500),
    wall_ceiling_cost: rand(0..500),
    painting_cost: rand(0..500),
    flooring_cost: rand(0..500),
    kitchen_cost: rand(0..500),
    furniture_cost: rand(0..500),
    facade_cost: rand(0..500),
    security_cost: rand(0..500),
    masonry_cost: rand(0..500),
    covering_cost: rand(0..500)
  )
end

p "#{tp Renovation.all}"
p "Creation Renovation... #{Renovation.count}"
p "DONE"
p "-----------------------"
p "-----------------------"

# old informations & new informations
25.times do |n|
  OldInformation.create!(
    type_id: rand(1..( types.length )),
    project_id: rand(1..( projects.length )),
    rooms_count: rand(1..10),
    surface: rand(8..400)
  )
  NewInformation.create!(
    type_id: rand(1..( types.length )),
    project_id: rand(1..( projects.length )),
    rooms_count: rand(1..10),
    surface: rand(8..400)
  )
end
p "#{tp OldInformation.all}"
p "Creation OldInformation... #{OldInformation.count}"
p "#{tp NewInformation.all}"
p "Creation OldInformation... #{NewInformation.count}"
p "DONE"
p "-----------------------"
p "-----------------------"

p " ********************************* "
p " *                               * "
p " *          END OF SEED          * "
p " *                               * "
p " ********************************* "
