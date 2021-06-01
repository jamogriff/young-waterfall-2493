class Actor < ApplicationRecord
  has_many :common_films
  has_many :movies, through: :common_films

  def self.working_by_age
    where(currently_working: true).order(:age)
  end

  def self.find_by_name(name)
    where("name = '#{name}'").first
  end
end

