class Pokemon < ActiveRecord::Base
  has_many :trainers, through: :rosters 
end
