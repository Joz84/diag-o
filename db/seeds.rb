# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Booking.destroy_all
puts "All tables are destroyed !"

puts "Generating random users"

#Users / Client
User.create!(email: "test@test", password: "test98776", first_name: "Jo", last_name: "Sera", address: "Floirac", phone:"06 11 22 33 44", role:0)
User.create!(email: "test1@test", password: "test1343", first_name: "Jules", last_name: "Mar", address: "Floirac", phone:"06 11 22 33 44", role:0)
User.create!(email: "test2@test", password: "test23453", first_name: "DiagoMax", last_name: "Bou", address: "Floirac", phone:"06 11 22 33 44", role:1)
User.create!(email: "test3@test.vm", password: "test35678", first_name: "DiagoSam", last_name: "Cha", address: "Floirac", phone:"06 11 22 33 44", role:1)

#Housings
Housing.create!(address:"Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")

#Bookings
Booking.create!(user_id:"1", housing_id:"", set_at:"01-01-2017", comment:"Booking is OK", confirmed_at:"02-01-2017")
