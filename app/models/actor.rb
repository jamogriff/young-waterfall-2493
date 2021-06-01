class Actor < ApplicationRecord
  has_many :common_films
  has_many :movies, through: :common_films

  def self.working_by_age
    where(currently_working: true).order(:age)
  end
end

