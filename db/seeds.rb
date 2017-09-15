#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
UserHousing.destroy_all
Booking.destroy_all
Housing.destroy_all
User.destroy_all
Diagnostic.destroy_all
Point.destroy_all
Zone.destroy_all
Town.destroy_all

puts "All tables are destroyed !"

puts "Generating random users"

#Users / Client
diagnostician = User.create!(email: "jo@yahoo.fr", password: "123456", first_name: "Jo", last_name: "Sera", address: "Floirac", phone:"06 11 22 33 44", role:1)
jules = User.create!(email: "jules@yahoo.fr", password: "123456", first_name: "Jules", last_name: "Marchello", address: "Bordeaux", phone:"06 11 22 33 44", role:1)
max = User.create!(email: "max@yahoo.fr", password: "123456", first_name: "Max", last_name: "Boue", address: "Bègles", phone:"06 11 22 33 44", role:1)
sami = User.create!(email: "sam@yahoo.fr", password: "123456", first_name: "Sam", last_name: "Chalalala", address: "Cenon", phone:"06 11 22 33 44", role:1)


#Housings
housing1 = Housing.create!(address:"Auchan drive Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: jules, housing: Housing.last, user_state: 1 )

housing2 = Housing.create!(address:"Auchan Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: jules, housing: Housing.last, user_state: 1 )

housing3 = Housing.create!(address:"Auchan drive Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: max, housing: Housing.last, user_state: 1 )

housing4 = Housing.create!(address:"Auchan drive Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: sami, housing: Housing.last, user_state: 1 )

puts "Housing créé: #{Housing.count}"
puts "UserHousing créé: #{UserHousing.count}"

housings = [housing1, housing2, housing3, housing4]


#Bookings
10.times do
  Diagnostic.create!
  Booking.create!(user_id: diagnostician.id, housing: housings.sample, diagnostic: Diagnostic.all.sample, set_at:"01-01-2017", start_hour:"8", comment:"Book seed #{Booking.count}", confirmed_at:"02-01-2017")
  Booking.create!(user_id: diagnostician.id, housing: housings.sample, diagnostic: Diagnostic.all.sample, set_at:"12-12-2017", start_hour:"8", comment:"Book seed #{Booking.count}", confirmed_at:"02-01-2017")

end

puts "Booking créé: #{Booking.count}"

serialized_file = File.read(Rails.root.join('lib', 'seeds', 'floirac_test.json'))

floirac = JSON.parse(serialized_file)
floirac_zones = floirac["features"]

floirac_zones.each do |zone|
  z = zone["properties"]
  name = z["NOM_COM"]
  zipcode = z["INSEE_COM"]
  unless Town.find_by_zipcode(zipcode)
    Town.create!(name: name, zipcode: zipcode)
    puts "Ville créée : #{Town.last.name}"
  end

  town_id = Town.find_by_zipcode(zipcode).id

  case z["codezone"]
    when "Zone rouge hachure bleue liser rouge" then color = "#D0021B"
    when "Zone rouge hachure bleue" then color = "#F5A623"
    when "Zone jaune" then color = "#F8E71C"
    else color = "#FFF9AC"
  end

  id_zone = z["ID_ZONE"]

  g = zone["geometry"]["coordinates"]

  if zone["geometry"]["type"] == "Polygon"
    Zone.create!(town_id: town_id, color: color, id_zone: id_zone)
    puts "Zone Polygone créée avec l'id: #{Zone.last.id_zone}"

      g[0].each do |point|
        lng = point[0]
        lat = point[1]
        Point.create!(zone_id: Zone.last.id, lat: lat, lng: lng)
        puts "Point créé pour polygone: lng:#{Point.last.lng}, lat#{Point.last.lat} pour zone #{Point.last.zone.id_zone}"
      end

  elsif zone["geometry"]["type"] == "MultiPolygon"
    g.each_with_index do |polygon, index|
      id_zone = z["ID_ZONE"] + "-#{index+1}"
      Zone.create!(town_id: town_id, color: color, id_zone: id_zone)
      puts "Zone Multipolygone créée avec l'id: #{Zone.last.id_zone}"

      g[index].each do |poly|
        poly.each do |point|
        lng = point[0]
        lat = point[1]
        Point.create!(zone_id: Zone.last.id, lat: lat, lng: lng)
        puts "Point créé pour Multipolygone: lng:#{Point.last.lng}, lat#{Point.last.lat} pour zone #{Point.last.zone.id_zone}"
      end
    end
    end
  end

end

