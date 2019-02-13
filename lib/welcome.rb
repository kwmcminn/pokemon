require 'pry'
def welcome
  puts "Welcome to the World of Pokemon!"
  # sleep(3)
  puts "Whoops, I apologize, but I can't recall your name"
  # sleep(4)
  puts "Can you jog my memory, please?"
  @name = gets.chomp.downcase
  puts "AH! That's right. Welcome #{@name.capitalize}."
  puts "And your age...?"
    age = gets.chomp.to_i
    Trainer.create(name: @name, age: age)
end


def choose_pokemon
  puts "Choose your starter Pokemon!"
  puts "1. Charmander"
  puts "2. Bulbasaur"
  puts "3. Squirtle"
  starter = gets.chomp.to_i
  if starter == 1
    add_pokemon_to_roster("charmander", @name)
    puts "Charmander! Great Choice!"
  elsif starter == 2
    add_pokemon_to_roster("bulbasaur", @name)
    puts "Bulbasaur! Great Choice!"
  elsif starter == 3
    add_pokemon_to_roster("squirtle", @name)
    puts "Squirtle! Great Choice!"
  else
    puts "That's not a valid response! Please type 1, 2, or 3 to choose your Pokemon"
    sleep(3)
    choose_pokemon
  end
end
