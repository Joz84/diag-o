Answer.destroy_all

Question.destroy_all
OptionChoice.destroy_all
OptionGroup.destroy_all
Section.destroy_all
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
diagnostician = User.create!(email: "jo@yahoo.fr", password: "123456", first_name: "Jo", last_name: "Sera", phone:"06 11 22 33 44", role:1)
jules = User.create!(email: "jules@yahoo.fr", password: "123456", first_name: "Jules", last_name: "Marchello", phone:"06 11 22 33 44", role:0)
max = User.create!(email: "max@yahoo.fr", password: "123456", first_name: "Max", last_name: "Boue", phone:"06 11 22 33 44", role:0)
sami = User.create!(email: "sam@yahoo.fr", password: "123456", first_name: "Sam", last_name: "Chalalala", phone:"06 11 22 33 44", role:0)

#Housings
housing1 = Housing.create!(address:"Auchan Drive Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: jules, housing: Housing.last, user_state: 1 )

housing2 = Housing.create!(address:" 2 rue de l'église Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: jules, housing: Housing.last, user_state: 1 )

housing3 = Housing.create!(address:" 6 Chemin de Créon 33270 BOULIAC", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: max, housing: Housing.last, user_state: 1 )

housing4 = Housing.create!(address:"gestion de l’eau 24 route de Latresne Bouliac", created_at:"01-01-2017", updated_at:"01-01-2017")
user_housing = UserHousing.create!(user: sami, housing: Housing.last, user_state: 1 )

puts "Housing créé: #{Housing.count}"
puts "UserHousing créé: #{UserHousing.count}"

housings = [housing1, housing2, housing3, housing4]

#Bookings
housings.each do |housing|
  Diagnostic.create!
  Booking.create!(user_id: diagnostician.id, housing: housing, diagnostic: Diagnostic.last, set_at:"#{rand(1..25)}-#{rand(9..12)}-2017", comment:"Book seed #{Booking.count}", confirmed_at: nil)
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

sections = ["inhabitant", "risk_awarness", "works_against_inondation", "place", "history",
"accessibility", "history_references", "housing", "structure", "refugee", "furniture", "exit", "airflow", "sanitation", "electricity", "warming"]
sections.each do |section|
  Section.create(name: section)
end
puts "Création des #{Section.all.size} sections"

units = ["cm", "m", "m^2", "km", "€", "jours", "années"]
units.each do |unit|
  Unit.create(name: unit)
end
puts "Création des #{Unit.all.size} unités de mesure"


option_groups = ["groupe 0", "groupe 1", "groupe 2", "groupe 3", "groupe 4", "groupe 5", "groupe 6"]
option_groups.each do |option|
  OptionGroup.create(name: option)
end
puts "Création des #{OptionGroup.all.size} option groups"

option_choices = {
  "groupe 0" => [],
  "groupe 1" => ["Vrai", "Faux", "NSP"],
  "groupe 2" => ["Oui", "Non", "Sans avis"],
  "groupe 3" => ["1", "2", "3", "4", "plus"],
  "groupe 4" => [1900..2017],
  "groupe 5" => [1..100000],
  "groupe 6" => ["", "nil"]
}

option_choices.each { |key, value|
  value.each {|choix|
    OptionChoice.create(option_group: OptionGroup.find_by(name: key), name: choix)
  }
}

# RAPPEL enum input_type: {option_choice_id: 0, numeric: 1, string: 2, boolean: 3}

puts "Création des #{OptionChoice.all.size} option choices"

question1 = Question.create( section_id: 1, name: "Nom de l’occupant principal?", information: "nom_habitant", input_type: 2)
question2 = Question.create( section_id: 1, name: "Nombre d'occupants?", information: "nombre_occupants", option_group_id: 3, input_type: 0)
question3 = Question.create( section_id: 1, name: "Nombre de mineurs?", information: "nombre_mineurs", option_group_id: 3, input_type: 0)
question4 = Question.create( section_id: 1, name: "Nombre de personnes âgées?", information: "nombre_seniors", option_group_id: 3, input_type: 0)
question5 = Question.create( section_id: 1, name: "Nombre de personnes à mobilité réduite?", information: "nombre_pmr", option_group_id: 3, input_type: 1)
question6 = Question.create( section_id: 1, name: "Nombre de personnes dépendantes autres?", information: "nombre_dependants", option_group_id: 3, input_type: 0)
question7 = Question.create( section_id: 1, name: "Année d'entrée dans le logement?", information: "duree_habitation", option_group_id: 4, input_type: 0)
question8 = Question.create( section_id: 4, name: "Superficie du terrain?", information: "superficie_terrain", option_group_id: 5, unit_id: 2, input_type: 1)
question9 = Question.create( section_id: 4, name: "Nombre de logements?", information: "nombre_logements", option_group_id: 3, input_type: 2)
question10 = Question.create( section_id: 4, name: "Surface habitable?", information: "surface_habitable", option_group_id: 5, unit_id: 2, input_type: 1)
question11 = Question.create( section_id: 4, name: "Année de construction?", information: "annee_construction", option_group_id: 4, input_type: 1)
question12 = Question.create( section_id: 2, name: "Avez-vous été informé d'un potentiel risque d'inondation de votre habitation à l'achat ou à la location ?", information: "conscience_risque", option_group_id: 2, input_type: 2)
question13 = Question.create( section_id: 2, name: "Avez-vous été informé des risques d'inondation sur la ville de Nîmes ?", information: "informe_zone", option_group_id: 2, input_type: 2)
question14 = Question.create( section_id: 2, name: "Votre habitation est-elle concernée par les risques d'inondation ?", information: "informe_habitation", option_group_id: 2, input_type: 2)
question15 = Question.create( section_id: 2, name: "Le risque d'inondation vous semble-t-il préoccupant ?", information: "risque_preoccupant", option_group_id: 2, input_type: 2)
question16 = Question.create( section_id: 2, name: "Avez-vous connaissance d'un Plan Communal de Sauvegarde ?", information: "informe_pcs", option_group_id: 2, input_type: 2)
question17 = Question.create( section_id: 2, name: "Savez-vous ce qu'est un PPRI?", information: "informe_ppri", option_group_id: 2, input_type: 2)
question18 = Question.create( section_id: 10, name: "Présence d'un espace refuge conforme au PPRi? ", information: "refuge_ppri", option_group_id: 3, input_type: 2)
question19 = Question.create( section_id: 10, name: "Superficie de l'espace", information: "superficie_espace", option_group_id: 5, unit_id: 2, input_type: 1)
question20 = Question.create( section_id: 10, name: "Possibilité d'évacuation ?", information: "evacuation", option_group_id: 2, input_type: 2)

