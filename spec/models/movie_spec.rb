require 'rails_helper'

RSpec.describe Movie do
  before :each do
    @marvel = Studio.create!(name: "Marvel Studios", location: "Hollywood")
    @iron_man = @marvel.movies.create!(title: "Iron Man", creation_year: 2003, genre: "Action")
    @avengers = @marvel.movies.create!(title: "The Avengers", creation_year: 2011, genre: "Action")
    @harrison = Actor.create!(name: "Harrison Ford", age: 71, currently_working: false)
    @scarlett = Actor.create!(name: "Scarlett Jo", age: 40, currently_working: true)
    @mike = Actor.create!(name: "Mike Birbiglia", age: 51, currently_working: true)
    @iron_man.actors << @harrison
    @iron_man.actors << @mike
    @avengers.actors << @scarlett
    @avengers.actors << @mike
  end

  describe 'relationships' do
    it {should belong_to :studio}
    it { should have_many :common_films }
    it { should have_many(:actors).through(:common_films) }
  end

  describe 'methods' do
    it 'returns actors from all of the studio\'s movies' do
      expect(@marvel.select_actors.first.name).to eq @scarlett.name
      expect(@marvel.select_actors.last.name).to eq @mike.name
    end
  end
end
