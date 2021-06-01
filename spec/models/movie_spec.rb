require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it { should have_many :common_films }
    it { should have_many(:actors).through(:common_films) }
  end
end
