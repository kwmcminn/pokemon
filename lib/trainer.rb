class Trainer < ActiveRecord::Base
 has_many :rosters
 has_many :pokemons, through: :rosters

 # def my_roster
 #    Roster.all.collect do |x|
 #     if x.trainer_id == self.id
 #       puts x.pokemon.name.capitalize
 #     end
 #   end
  # end

   def add_pokemon_to_roster(pokemon)
     Roster.create(trainer_id: self.id, pokemon_id: pokemon.id)
     sleep(2)
     puts "Added #{pokemon.name.capitalize} to your roster."
   end

   def remove_pokemon_from_roster(pokemon)
     roster = Roster.find_by(trainer_id: self.id, pokemon_id: pokemon.id)
     Roster.delete(roster.id)
     sleep(2)
     puts "Removed #{pokemon.name.capitalize} from your roster."
   end

   def my_pokemon
     Roster.all.select {|x| x.trainer == self}
   end

   def roster
     i = 1
     my_pokemon.each_with_index{|x, index| puts "#{index + 1}. " + x.pokemon.name.capitalize}
   end

   # def pokedex_menu
   #
   # end
   # pokemon = Pokemons.find_by name: pokemon.to_s.downcase
   # pokemon_id = pokemon.id
   # trainer = Trainers.find_by name: trainer.to_s.downcase
   # trainer_id = self.id
   # Roster.create(trainer_id: trainer_id, pokemon_id: pokemon_id)
 # end
end
