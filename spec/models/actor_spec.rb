require 'rails_helper'

RSpec.describe Actor do

  before :each do
    Actor.destroy_all
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
    it { should have_many :common_films }
    it { should have_many(:movies).through(:common_films) }
  end

  describe 'class methods' do
    it 'should return list of working actors from oldest to youngest' do
      expect(Actor.working_by_age.first).to eq @scarlett
      expect(Actor.working_by_age.last).to eq @mike
      expect(Actor.working_by_age.include?(@harrison)).to eq false
    end

    it 'finds actor by name' do
      expect(Actor.find_by_name("Scarlett Jo")).to eq @scarlett
      expect(Actor.find_by_name("Simon")).to eq nil
    end

    it 'returns list of coactors' do
      expect(Actor.coactors_of(@mike.id)).to eq [@scarlett, @harrison]
    end
  end

end
