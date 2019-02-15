require 'pry'

class Game
  attr_reader :trainer

  def welcome
    puts "Welcome to the World of..."
    sleep(2)
    animation2
    sleep(2)
    animation
    sleep(2)
    puts "Whoops, I apologize, but I can't recall your name"
    sleep(2)
    puts "Can you jog my memory, please?"
    name = gets.chomp.downcase
    puts "AH! That's right. Welcome #{name.capitalize}."
    puts "And your age...?"
    age = gets.chomp.to_i
    @trainer = Trainer.find_or_create_by(name: name, age: age)
    if @trainer.starter?
      puts
      puts "So nice to see you again, #{name.capitalize}!"
    end
  end

  def choose_pokemon
    if @trainer.starter? == false
      #checks to see if a trainer has picked a starter previously
      puts "Choose your starter Pokémon!"
      puts "1. Charmander"
      puts "2. Bulbasaur"
      puts "3. Squirtle"
      starter = gets.chomp.to_i
      if starter == 1
        puts "Charmander! Great Choice!"
        @trainer.add_pokemon_to_roster(Pokemon.all[3])
        sleep(1)
        @trainer.update_starter
      elsif starter == 2
        puts "Bulbasaur! Great Choice!"
        @trainer.add_pokemon_to_roster(Pokemon.all[0])
        sleep(1)
        @trainer.update_starter
      elsif starter == 3
        puts "Squirtle! Great Choice!"
        @trainer.add_pokemon_to_roster(Pokemon.all[6])
        sleep(1)
        @trainer.update_starter
      else
        puts "That's not a valid response! Please type 1, 2, or 3 to choose your Pokemon"
        sleep(3)
        choose_pokemon
      end
    end
  end

  def main_menu
    puts
    puts "---------------------------------"
    sleep(0.5)
    puts "Main Menu"
    sleep(0.5)
    puts "...What would you like to do, #{@trainer.name.capitalize}?"
    puts
    sleep(1.5)
    menu_items
    user_choice = gets.chomp.to_i
    action_launcher(user_choice)
  end

  def menu_items
    sleep(0.5)
    puts "1. Catch Pokémon!"
    sleep(0.5)
    puts "2. Check Your PokéSquad"
    sleep(0.5)
    puts "3. Check the Pokédex"
    sleep(0.5)
    puts "4. Release Pokémon"
    sleep(0.5)
    puts "5. Exit Game"
    sleep(0.5)
    puts "---------------------------------"
    print "Where would you like to go? Enter 1-5: "
  end

  def action_launcher(user_choice)
    if user_choice == 1
      self.catch
      main_menu
    elsif user_choice == 2
      puts
      puts "#{@trainer.name.capitalize}'s Squad:"
      puts
      sleep(1)
      @trainer.roster
      main_menu
    elsif user_choice == 3
      self.pokedex_menu
      main_menu
    elsif user_choice == 4
      self.release
      main_menu
    elsif user_choice == 5
      sleep(0.5)
    puts
    abort("Thanks for playing!")

    else
      puts "Please select a valid option"
      main_menu
    end
  end

  def pokedex_menu
    puts "<<<<<<<<<<<<<<"
    puts " Pokedex Menu"
    puts ">>>>>>>>>>>>>>"
    puts "What would you like to know?"
    puts "1. Search by Pokémon name"
    puts "2. Search by Pokémon type"
    puts "3. List all Pokémon"
    puts "4. Exit to Main Menu"
    choice = gets.chomp.to_i
    if choice == 1
      search_pokemon_by_name
    elsif choice == 2
      search_by_type
    elsif choice == 3
      list_all_pokemon
    elsif choice == 4
      main_menu
    end
  end

  def search_pokemon_by_name
    puts "Please enter the name of a Pokémon, or type 'Exit' to go back."
    pokemon_name = gets.chomp.downcase
    poke_search(pokemon_name)
  end

  def pokemon_stats(chosen_pokemon)
    puts
    puts "--------------------"
    puts "Name: #{chosen_pokemon.name.capitalize}"
    if chosen_pokemon.type2
      puts "Types: #{chosen_pokemon.type2.capitalize}/#{chosen_pokemon.type1.capitalize}"
    else
      puts "Type: #{chosen_pokemon.type1.capitalize}"
    end
    puts "HP: #{chosen_pokemon.hp}"
    puts "Weight: #{chosen_pokemon.weight}"
    puts "Height: #{chosen_pokemon.height}"
    puts "Primary Move: #{chosen_pokemon.signature_move.capitalize}"
    puts "--------------------"
    sleep(3)
    search_pokemon_by_name
  end



  def poke_search(pokemon_name)
    chosen_pokemon = Pokemon.all.find{|pokemon| pokemon.name == pokemon_name}
    if chosen_pokemon
          pokemon_stats(chosen_pokemon)
  elsif exit_menu(pokemon_name)
    #if they type exit, go back a menu
      sleep(1)
      pokedex_menu
  else
    sleep(2)
    puts
    puts "Hmmm... Couldn't find a pokémon named '#{pokemon_name.capitalize}'. Please try again"
    puts
    sleep(1.5)
    search_pokemon_by_name
  end
end

  def list_all_pokemon
    pokemon_names = Pokemon.all.map {|pokemon| pokemon.name.capitalize}
    alphabetized = pokemon_names.sort
    puts pokemon_names.join(", ")
    puts
    sleep(3)
    pokedex_menu
  end

  def search_by_type
    puts "Please enter a Pokémon type or 'Exit' to leave:"
    type = gets.chomp.downcase
    all_pokemon_type_c = Pokemon.all.map{|x| x.type1.capitalize}.uniq
    all_pokemon_type = Pokemon.all.map{|x| x.type1}.uniq
    i = 1
    puts "Here are all of the pokemon that match the type: #{type.capitalize}"
    if exit_menu(type)
      #if they type exit, go back a menu
      pokedex_menu
    elsif all_pokemon_type.include?(type)
      Pokemon.all.each do |x|
        if x.type1 == type || x.type2 == type
          puts "#{i}. #{x.name.capitalize}"
          i += 1
        end
      end
      search_by_type
    else
        puts "Sorry, don't recognize that type"
        sleep(1)
        puts "Here are all the types you can search:"
        sleep(2)
        print all_pokemon_type_c.sort.join(", ")
        puts

        search_by_type
      end
      sleep(3)
      pokedex_menu
    end

  def release
    #Removes chosen Pokemon from Roster.
      puts "Which Pokémon would you like to release?"
      puts
      puts "Your current roster:"
      @trainer.my_pokemon.each{|x| puts "-#{x.pokemon.name.capitalize}"}
      puts
      puts "Please enter the name of the Pokémon you want to release or 'Exit' to leave: "
      poke_name = gets.chomp.downcase
      poke_object = Pokemon.all.find{|x| x.name == poke_name}
      if exit_menu(poke_name)
        #if they type exit, go back a menu
        sleep(1)
        main_menu
      elsif poke_object == nil
        sleep(1)
        puts "Please check your spelling. We couldn't find that Pokémon on your roster"
      else
      @trainer.remove_pokemon_from_roster(poke_object)
    end
    sleep(3)
    release
  end

  def catch
    #Catch gameplay loop.

    rand_pokemon = Pokemon.all.sample
    rand_pokemon_name = rand_pokemon.name.capitalize
    catch_attempts = 0
    escape_chance = rand(1..5)
    rand_number = rand(1..3)
    puts
    pokeball
    sleep (1)
    puts
    puts

    puts "A wild #{rand_pokemon_name} has appeared!"
        while catch_attempts < escape_chance
          sleep(3)
          puts "Enter 1, 2, or 3 to try and catch #{rand_pokemon_name}!!!"
          choice = gets.chomp.to_i
          if choice == rand_number
            puts "Success! You have caught #{rand_pokemon_name}!"
            @trainer.add_pokemon_to_roster(rand_pokemon)
            sleep(2)
            main_menu
          else
            puts "Uh oh! #{rand_pokemon_name} escaped the pokéball!"
            sleep(2)
            catch_attempts += 1
          end
        end
    puts "Oh no! #{rand_pokemon_name} has run away!"
    sleep(2)
    puts "Would you like to try again? (Yes/No)"
    if gets.chomp.downcase[0] == "y"
      catch
    else
      puts "Ok! Better luck next time!"
      main_menu
    end
  end

  def exit_menu(user_input)
    if user_input == "e" || user_input == "exit"
      return true
    end
  end

  def animation
      puts "                             `;-.          ___,     "
      sleep(0.2)
      puts "                           `.`\\_...._/`.-'`         "
      sleep(0.2)
      puts "                            \\        /      ,      "
      sleep(0.2)
      puts "                             /()   () \\    .' `-._ "
      sleep(0.2)
      puts "                            |)  .    ()\\  /   _.'  "
      sleep(0.2)
      puts "                            \\  -'-     ,; '. <     "
      sleep(0.2)
      puts "                             ;.__     ,;|   > \\    "
      sleep(0.2)
      puts "                            / ,    / ,  |.-'.-'     "
      sleep(0.2)
      puts "                           (_/    (_/ ,;|.<`        "
      sleep(0.2)
      puts "                             \\    ,     ;-`        "
      sleep(0.2)
      puts "                              >   \\    /           "
      sleep(0.2)
      puts "                             (_,-'`> .'             "
      sleep(0.2)
      puts "                                  (_,'              "
  end

  def animation2
      puts"    ,'\\                                                                "
      puts"_.----.        ____         ,'  _\\   ___    ___     ____               "
      puts" _,-'       `.     |    |  /`.   \\,-'    |    \\  /   |   |    \\  |`.    "
      puts"  \\      __    \\    '-.  | /   `.  ___    |    \\/    |   '-.   \\ |  |  "
      puts"   \\.    \\ \\   |  __  |  |/    ,','_  `.  |          | __  |    \\|  |  "
      puts"     \\    \\/   /,' _`.|      ,' / / / /   |          ,' _`.|     |  |  "
      puts"      \\     ,-'/  /   \\    ,'   | \\/ / ,`.|         /  /   \\  |     |  "
      puts"       \\    \\ |   \\_/  |   `-.  \\    `'  /|  |    ||   \\_/  | |\\    |  "
      puts"        \\    \\ \\      /       `-.`.___,-' |  |\\  /| \\      /  | |   |  "
      puts"         \\    \\ `.__,'|  |`-._    `|      |__| \\/ |  `.__,'|  | |   |  "
      puts"          \\_.-'       |__|    `-._ |              '-.|     '-.| |   |  "
      puts"           `'                                                    "
  end

  def pokeball
puts"                     *************                       "
sleep(0.1)
puts"                  *********************                  "
sleep(0.1)
puts"               ***************************     "
sleep(0.1)
puts"            *********************************  "
sleep(0.1)
puts"          ****************___******************  "
sleep(0.1)
puts"         ****************/ _ \\******************     "
sleep(0.1)
puts"        ----------------/ / \\ \\------------------    "
sleep(0.1)
puts"       -----------------\\ \\_/ /-------------------   "
sleep(0.1)
puts"       ------------------\\___/--------------------  "
sleep(0.1)
puts"       *******************************************  "
sleep(0.1)
puts"       *******************************************   "
sleep(0.1)
puts"       *******************************************   "
sleep(0.1)
puts"        *****************************************   "
sleep(0.1)
puts"         ***************************************   "
sleep(0.1)
puts"          *************************************      "
sleep(0.1)
puts"            *********************************      "
sleep(0.1)
puts"              *****************************      "
sleep(0.1)
puts"                *************************      "
sleep(0.1)
puts"                   ******************      "
end

end #end of game class
