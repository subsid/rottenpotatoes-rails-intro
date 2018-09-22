class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_ratings
    ratings_hash = Hash[@all_ratings.map {|r| [r, 1]}]

    # If session params are used, then send them as params to maintain RESTfulness
    redirect = false
    redirect_params = {}

    if (params[:order].nil? and !session[:order].nil?)
      redirect = true
      redirect_params = redirect_params.merge({ order: session[:order] })
    end

    if (params[:ratings].nil? and !session[:ratings].nil?)
      redirect = true
      redirect_params = redirect_params.merge({ ratings: session[:ratings] })
    end

    if redirect
      redirect_params = redirect_params
        .merge(params[:order] ? { order: params[:order] } : {})
        .merge(params[:ratings] ? { ratings: params[:ratings] } : {})
      flash.keep
      redirect_to movies_path redirect_params
    end

    session[:order] = params[:order]
    session[:ratings] = params[:ratings] || ratings_hash

    @sorted_by = params[:order]
    @filtered_ratings = session[:ratings].keys()
    @movies_filtered = Movie.where(:rating => @filtered_ratings)
    @movies = session[:order] ? @movies_filtered.order(session[:order]) : @movies_filtered
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
