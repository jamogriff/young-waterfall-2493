require 'rails_helper'

RSpec.describe 'Movie info page' do

  before :each do
    @marvel = Studio.create!(name: "Marvel Studios", location: "Hollywood")
    @iron_man = @marvel.movies.create!(title: "Iron Man", creation_year: 2003, genre: "Action")
    @harrison = Actor.create!(name: "Harrison Ford", age: 71, currently_working: false)
    @mike = Actor.create!(name: "Mike Birbiglia", age: 51, currently_working: true)
    @scarlett = Actor.create!(name: "Scarlett Jo", age: 40, currently_working: true)
    @iron_man.actors << @harrison
    @iron_man.actors << @mike
  end

  describe 'items on the page' do
    it 'has list of actors' do
      visit "/movies/#{@iron_man.id}"
      expect(page).to have_content @mike.name
      expect(page).to have_content @harrison.name
      expect(page).not_to have_content @scarlett.name
    end

    it 'has form functionality' do
      visit "/movies/#{@iron_man.id}"
      fill_in "actor_name", with: "Scarlett Jo"
      click_button "Submit"
      expect(page).to have_content @scarlett.name
    end

    it 'has sad path form functionality' do
      skip "experimental"
      visit "/movies/#{@iron_man.id}"
      fill_in "actor_name", with: "Garbage Jo"
      click_button "Submit"
      save_and_open_page
      expect(page).to have_content "Error! Actor Doesn't Exist"
    end
  end
end
