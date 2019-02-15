class AddColumnsToTrainers < ActiveRecord::Migration
    def change
       add_column :trainers, :starter?, :boolean, default: false
     end
    end