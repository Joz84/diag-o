class ParsingImmo

require 'json'
require 'open-uri'

  params = { geoloc: "27 rue du chemin vert, Paris",
         floor: 2,
         surface: 40,
         rooms: 3 }

  api_key = "12a30e3632a51fdab4fedd07bcc219b433e17343"
  base_url = "https://bdvapis.appspot.com/" + api_key + "/valuation/v1.0.0/purchase?"
  sum = ""

  params.to_a.flatten.each{|e| sum += e.to_s + (e.class.to_s == "Symbol" ? "?=" : "&") }

  elementstring = sum[0...-1]

  url = base_url + elementstring

  url_serialized = open(url).read
  result = JSON.parse(url_serialized)

  puts "#{status} - #{message}"

end
