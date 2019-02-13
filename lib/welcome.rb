require 'pry'
def welcome
  puts "Welcome to the World of Pokemon!"
  # sleep(3)
  puts "Whoops, I apologize, but I can't recall your name"
  # sleep(4)
  puts "Can you jog my memory, please?"
  name = gets.chomp
  puts "AH! That's right. Welcome #{name}."
  puts "And your age...?"
    age = gets.chomp.to_i
    Trainer.create(name: name, age: age)
end


def choose_pokemon
  puts "Choose your starter Pokemon!"
  puts "1. Charmander"
  puts "2. Bulbasaur"
  puts "3. Squirtle"
end
