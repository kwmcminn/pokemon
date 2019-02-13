class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.integer :trainer_id
      t.integer :pokemon_id

      t.timestamps 
    end
  end
end
