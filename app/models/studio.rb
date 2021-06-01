class Studio < ApplicationRecord
  has_many :movies

  # kind of awkward because movie objects are returned instead of actors, but all the data is there
  def select_actors
    movies.select('actors.*').joins(:actors).where("actors.currently_working = true").order("actors.age").distinct
    #binding.pry
  end
end
