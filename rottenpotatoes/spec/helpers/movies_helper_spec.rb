require 'rails_helper'

RSpec.describe MoviesHelper, type: :helper do

    describe 'Oddness Checks' do
         it 'Checks if a number is odd' do
            expect(oddness(5)).to eq('odd')
         end
         it 'Checks if a number is even' do
            expect(oddness(6)).to eq('even')
         end
    end
end