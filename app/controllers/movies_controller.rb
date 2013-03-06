class MoviesController < ApplicationController
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  
  def index
      
    @all_ratings=Movie.mpaa_rating
    @movies=Array.new
    if params[:ratings].present? and params[:commit]=='Refresh'
      
      session[:return_to]=request.url
      @kljucevi=params[:ratings].keys
      @kljucevi.each do |rate|
        @movies.push(Movie.where("rating=?",rate)).flatten!
      end
        
    else
      @movies.push(Movie.all).flatten!
      
      if session[:return_to]!=nil
        redirect_to session[:return_to]
      end
      
    end
    
    if params[:order]=='movie_order_asc'
      @movies.sort_by!{|e| e[:title]}
    end

    if params[:order]=='release_order_asc'
      @movies.sort_by!{|e| e[:release_date]}
    end
  end  



  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
