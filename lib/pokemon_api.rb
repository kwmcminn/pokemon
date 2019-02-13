# require 'rest-client'
# require 'json'
# require 'pry'
require_relative '../config/environment'

def create_new_pokemon
  url = "https://pokeapi.co/api/v2/pokemon?limit=151"

   response_string = RestClient.get(url)
   poke_hash = JSON.parse(response_string)

   poke_hash.each do |k,v|
      if k == "results"
        v.each do |x|
        attribute_url = x["url"]

        attribute_info = RestClient.get(attribute_url)
        attribute_hash = JSON.parse(attribute_info)
        height = attribute_hash["height"]
        weight = attribute_hash["weight"]
        name = attribute_hash["name"]
        Pokemon.create(name: name, weight: weight, height: height)

        end
      end
    end
  end


  #  poke_hash = response_hash["results"].find { |data| data["films"]}
  #   film_data = film_links.collect { |data| JSON.parse(RestClient.get(data)) }
	# film_data
