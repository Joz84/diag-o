#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
