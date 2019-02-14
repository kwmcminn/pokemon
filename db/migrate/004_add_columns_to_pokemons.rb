class AddColumnsToPokemons < ActiveRecord::Migration
def change
   add_column :pokemons, :type1, :string
   add_column :pokemons, :type2, :string
   add_column :pokemons, :hp, :integer
   add_column :pokemons, :signature_move, :string
 end
end
