# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Booking.destroy_all
Housing.destroy_all
User_housing.destroy_all
puts "All tables are destroyed !"

#User
User.create!(firstname: "Jo", lastname: "Seraf", email: "test1@test", password: "test", address: "113 Rue Jules Guesde Floirac France")
User.create!(firstname: "Mike", lastname: "Horn", email: "test2@test", password: "test", address: "114 Rue Jules Guesde Floirac France")

#Housing
Housing.create!(address:"113 Rue Jules Guesde Floirac France")

#User_housing
User_housing.create!(user_state: "Dangerous")

#Booking
Booking.create!(set_at: "01/30/18", comment: "C'est un véritable tsunami", confirmed_at:"01/08/18")
