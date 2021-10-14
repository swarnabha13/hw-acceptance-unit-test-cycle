class DirectorsController < ApplicationController
  def show
    id = params[:id] 
    @movie = Movie.find(id) 
    @director = @movie.director
    if @director == nil || @director == ''
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to "/movies" and return
    end
    @results = Movie.with_director(@director)
    if @results == nil
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to "/movies" and return
    end
  end
end