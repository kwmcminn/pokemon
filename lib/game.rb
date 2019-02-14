require 'pry'

class Game
  attr_reader :trainer

  def welcome
    puts "Welcome to the World of Pokémon!"
    # sleep(3)
    puts "Whoops, I apologize, but I can't recall your name"
    # sleep(4)
    puts "Can you jog my memory, please?"
    name = gets.chomp.downcase
    puts "AH! That's right. Welcome #{name.capitalize}."
    puts "And your age...?"
    age = gets.chomp.to_i
    @trainer = Trainer.create(name: name, age: age)
  end

  def choose_pokemon
    puts "Choose your starter Pokémon!"
    puts "1. Charmander"
    puts "2. Bulbasaur"
    puts "3. Squirtle"
    starter = gets.chomp.to_i
    if starter == 1
      @trainer.add_pokemon_to_roster(Pokemon.all[3])
      puts "Charmander! Great Choice!"
    elsif starter == 2
      @trainer.add_pokemon_to_roster(Pokemon.all[0])
      puts "Bulbasaur! Great Choice!"
    elsif starter == 3
      @trainer.add_pokemon_to_roster(Pokemon.all[6])
      puts "Squirtle! Great Choice!"
    else
      puts "That's not a valid response! Please type 1, 2, or 3 to choose your Pokemon"
      sleep(3)
      choose_pokemon
    end
  end

  def main_menu
    puts "---------------------------------"
    puts "Main Menu"
    sleep(1.5)
    puts "...What would you like to do?"
    sleep(2)
    menu_items
    user_choice = gets.chomp.to_i
    action_launcher(user_choice)
  end

  def menu_items
    puts "1. Catch Pokémon!"
    sleep(1)
    puts "2. Check Your PokéSquad"
    sleep(1)
    puts "3. Check the Pokédex"
    sleep(1)
    puts "4. Release Pokémon"
  end

  def action_launcher(user_choice)
    if user_choice == 1
      @trainer.catch
      main_menu
    elsif user_choice == 2
      @trainer.roster
      main_menu
    elsif user_choice == 3
      self.pokedex_menu
      main_menu
    elsif user_choice == 4
      @trainer.release
      main_menu
    else
      puts "Please select a valid option"
      menu_items
    end
  end

  def pokedex_menu
    puts "<<<<<<<<<<<<<<"
    puts " Pokedex Menu"
    puts ">>>>>>>>>>>>>>"
    puts "What would you like to know?"
    puts "1. Search by Pokémon name"
    puts "2. Search by Pokémon type"
    choice = gets.chomp.to_i
    if choice == 1
      search_pokemon_by_name
    end
  end

  def search_pokemon_by_name
    puts "Please enter the name of a Pokémon or type 'Exit' to go back..."
    pokemon_name = gets.chomp.downcase
    poke_search(pokemon_name)
  end

  def pokemon_stats(chosen_pokemon)
    puts "Name: #{chosen_pokemon.name.capitalize}"
    if chosen_pokemon.type2
      puts "Types: #{chosen_pokemon.type2.capitalize}/#{chosen_pokemon.type1.capitalize}"
    else
      puts "Type: #{chosen_pokemon.type1.capitalize}"
    end
    puts "HP: #{chosen_pokemon.hp}"
    puts "Weight: #{chosen_pokemon.weight}"
    puts "Height: #{chosen_pokemon.height}"
    search_pokemon_by_name
  end



  def poke_search(pokemon_name)
    chosen_pokemon = Pokemon.all.find{|pokemon| pokemon.name == pokemon_name}
    if chosen_pokemon
          pokemon_stats(chosen_pokemon)        
  elsif pokemon_name == "e" || "exit"
      sleep(1)
      self.pokedex_menu
  else
    sleep(2)
    puts "Hmmm...Couldn't find a pokémon named '#{pokemon_name.capitalize}'. Please try again"
    sleep(1.5)
    search_pokemon_by_name
  end
end
end
