require 'rails_helper'

RSpec.describe 'Studio info page' do

  before :each do
    @marvel = Studio.create!(name: "Marvel Studios", location: "Hollywood")
    @iron_man = @marvel.movies.create!(title: "Iron Man", creation_year: 2003, genre: "Action")
    @avengers = @marvel.movies.create!(title: "The Avengers", creation_year: 2011, genre: "Action")
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
  end

end

