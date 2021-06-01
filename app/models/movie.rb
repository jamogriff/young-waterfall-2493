class Movie < ApplicationRecord
  belongs_to :studio
  has_many :common_films
  has_many :actors, through: :common_films
end
