require 'rails_helper'

RSpec.describe Actor do

  before :each do
    Actor.destroy_all
    @harrison = Actor.create!(name: "Harrison Ford", age: 71, currently_working: false)
    @scarlett = Actor.create!(name: "Scarlett Jo", age: 40, currently_working: true)
    @mike = Actor.create!(name: "Mike Birbiglia", age: 51, currently_working: true)
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
  end
end
