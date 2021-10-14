require 'rails_helper'

RSpec.describe DirectorsController, type: :controller do
    describe 'Directors Page' do
        render_views
        it 'Data populates properly in the index page' do
            movie1 = Movie.create({:title => 'Star Wars', :rating => 'PG', :release_date => '1977-05-25', :director => 'George Lucas'})
            movie2 = Movie.create({:title => 'THX-1138', :rating => 'R', :release_date => '1971-03-11', :director => 'George Lucas'})
            get :show, :id => movie1.id
            expect(response).to be_successful
            expect(response.body).to include("THX-1138")
        end
        it 'Redirects to movie page if there are no match for the director' do
            movie1 = Movie.create({:title => 'Alien', :rating => 'R', :release_date => '1977-05-25'})
            get :show, :id => movie1.id
            response.code.should == "302"
            response.should redirect_to(movies_path)
        end
    end
end