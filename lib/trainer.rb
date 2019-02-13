class Trainer < ActiveRecord::Base
  has_many :pokemon, through: :roster
end 
