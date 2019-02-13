class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|

      t.string :name
      t.integer :age
    end
  end   
end
