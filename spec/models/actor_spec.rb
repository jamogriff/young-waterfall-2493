require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it { should have_many :common_films }
    it { should have_many(:movies).through(:common_films) }
  end
end
