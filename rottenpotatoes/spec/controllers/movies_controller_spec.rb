require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    render_views

    describe 'Index Page' do
        it 'Data populates properly in the index page' do
            Movie.create({:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'})
            get :index
            expect(response).to be_successful
            expect(response.body).to include("Aladdin")
        end
    end

    describe 'Sorting alphabetically' do
        it 'Should sort the movies alphabetically' do
            Movie.create({:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'})
            Movie.create({:title => 'The Incredibles', :rating => 'PG', :release_date => '05-Nov-2004'})
            get :index, :sort => 'title'
            expect(response).to be_successful
            expect(response.body).to include("Aladdin")
            expect(response.body).to include("The Incredibles")
            expect(response.body.index("Aladdin") < response.body.index("The Incredibles"))
        end
    end
    
    describe 'Create a new movie' do
        it 'Should create a new movie based on parameters passed and then redirect to movies page' do
            params = ActionController::Parameters.new(movie: { title: "Aladdin", rating: 'G', release_date: "25-Nov-1992" })
            post :create, params
            response.code.should == "302"
            response.should redirect_to(movies_path)
            get :index
            expect(response.body).to include("Aladdin")
        end
    end

    describe 'Check data consistency for director field' do
        it 'If there is a director return movies with that director' do
            movie1 = Movie.create({:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas'})
            movie2 = Movie.create({:title => 'THX-1138', :rating => 'R', :director => 'George Lucas'})
            directors = Movie.with_director(movie1.director)
            expect(directors).not_to be_empty
            expect(directors.size()).to be 2
        end
        it 'If there is no director return nil' do
            movie1 = Movie.create({:title => 'Alien', :rating => 'R'})
            directors = Movie.with_director(movie1.director)
            expect(directors).to be nil
        end
    end

    describe 'Delete a movie' do
        it 'Should delete a movie based on parameters passed and then redirect to movies page' do
            movie = Movie.create({:title => 'Aladdin', :rating => 'G', :release_date => '28-Nov-1992'})
            get :destroy, :id => movie.id 
            response.code.should == "302"
            response.should redirect_to(movies_path)
        end
    end
end