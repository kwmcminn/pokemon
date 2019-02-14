class Trainer < ActiveRecord::Base
 has_many :rosters
 has_many :pokemons, through: :rosters

 def my_roster
    Roster.all.collect do |x|
     if x.trainer_id == self.id
       puts x.pokemon.name.capitalize
     end
   end
  end

   def add_pokemon_to_roster(pokemon)
     Roster.create(trainer_id: self.id, pokemon_id: pokemon.id)
     puts "Added #{pokemon.name.capitalize} to your roster."
   end

   def catch
     rand_pokemon = Pokemon.all.sample
     rand_pokemon_name = rand_pokemon.name.capitalize

     rand_number = rand(1..3)
     puts "A wild #{rand_pokemon_name} has appeared!"
     sleep(3)
     puts "Enter 1, 2, 3 to see if you catch #{rand_pokemon_name}!!!"
     choice = gets.chomp.to_i
     if choice == rand_number
       puts "Success! You have caught #{rand_pokemon_name}!"
       add_pokemon_to_roster(rand_pokemon)
     else
       puts "Oh no! #{rand_pokemon_name} has run away!"
       sleep(3)
       puts "Would you like to try again? (Yes/No)"
       if gets.chomp.downcase[0] == "y"
         catch
       else
         puts "Ok! Better luck next time!"
       end
     end
   end

   def my_pokemon
     Roster.all.select {|x| x.trainer == self}
   end

   def roster
     my_pokemon.each{|x| puts x.pokemon.name.capitalize}
   end

   # pokemon = Pokemons.find_by name: pokemon.to_s.downcase
   # pokemon_id = pokemon.id
   # trainer = Trainers.find_by name: trainer.to_s.downcase
   # trainer_id = self.id
   # Roster.create(trainer_id: trainer_id, pokemon_id: pokemon_id)
 # end
end
