class Actor < ApplicationRecord
  has_many :common_films
  has_many :movies, through: :common_films
end
