class Trainer < ActiveRecord::Base
 has_many :rosters
 has_many :pokemons, through: :rosters

 def my_roster
   Roster.all.select{|x| x.trainer_id == self.id}
 end
end
