class Studio < ApplicationRecord
  has_many :movies

  def select_actors
    movies.select('actors.*').joins(:actors).where("actors.currently_working = true").order("actors.age").distinct
    #binding.pry
  end
end
