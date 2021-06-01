class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
  end

  def create_actor
    @movie = Movie.find(params[:id])
    actor = Actor.find_by_name(params[:actor_name])# find_by_name method
    if actor.present?
      @movie.actors << actor
      render :show
    else
      # experimental 
      render :show
      flash[:alert] = "Error! Actor Doesn't Exist!"
    end
  end

end
