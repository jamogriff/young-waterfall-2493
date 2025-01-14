require 'rails_helper'

RSpec.describe 'Studio info page' do

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

  describe 'items shown on page' do
    it 'has name and location of studio' do
      visit "/studios/#{@marvel.id}"
      expect(page).to have_content @marvel.name
      expect(page).to have_content @marvel.location
    end

    it 'has names of its movies' do
      visit "/studios/#{@marvel.id}"
      expect(page).to have_content @iron_man.title
      expect(page).to have_content @avengers.title
    end

    it 'has list of currently working actors ordered by age' do
      visit "/studios/#{@marvel.id}"
      within "section#all-actors" do
        expect(@scarlett.name).to appear_before(@mike.name)
        expect(page).not_to have_content @harrison.name
      end
    end

    it 'lists movies details and all actors in that movie' do
      visit "/studios/#{@marvel.id}"
      within "div#movie-#{@iron_man.id}" do
        expect(page).to have_content @harrison.name
        expect(page).to have_content @mike.name
        expect(page).to have_content @iron_man.creation_year
        expect(page).to have_content @iron_man.genre
        expect(page).not_to have_content @scarlett.name
      end
    end

  end

end

