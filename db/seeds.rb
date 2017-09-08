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
  colore = z["codezone"]
  id_zone = z["ID_ZONE"]

  g = zone["geometry"]["coordinates"]
  h =

  if zone["geometry"]["type"] == "Polygon"
    Zone.create!(town_id: town_id, colore: colore, id_zone: id_zone)
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
      Zone.create!(town_id: town_id, colore: colore, id_zone: id_zone)
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

