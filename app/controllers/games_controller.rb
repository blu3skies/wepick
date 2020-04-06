class GamesController < ApplicationController

  @@friend_id = 0
  
  def new
    @@friend_id = params[:friend_id]
    redirect_to '/games/preferences'
  end 

  def create
  end

  def index
    session[:genre] = params[:genre] unless params[:genre].nil?
    movies_by_genre = Movie.where('genre LIKE ?', "%#{session[:genre]}%").to_a
    movies_id_arr = movies_by_genre.map { |movie| movie.id }
    @movie = Movie.find(movies_id_arr[current_user.movie_counter])
    if mutual_match(current_user.id, @@friend_id).empty?
      @match = ""
    else
      @match = "You Matched"
      @movie = Movie.find(mutual_match(current_user.id, @@friend_id)[0])
    end
  end

  def preferences
  end 

  def destroy
    movie_counter = 0
    User.where(id: params[:user_id]).update_all(movie_counter: movie_counter)
    MovieLike.where(user_id: params[:user_id]).destroy_all
    User.where(id: @@friend_id).update_all(movie_counter: movie_counter)
    MovieLike.where(user_id: @@friend_id).destroy_all
    redirect_to '/friendships/show'
  end

  def like
    MovieLike.create(user_id: params[:user_id], movie_id: params[:movie_id])
    movie_counter = current_user.movie_counter + 1
    User.where(id: params[:user_id]).update_all(movie_counter: movie_counter)
    redirect_to '/games'
  end

  def dislike
    movie_counter = current_user.movie_counter + 1
    User.where(id: params[:user_id]).update_all(movie_counter: movie_counter)
    redirect_to '/games'
  end 

  def mutual_match(user_id, friend_id)
    user_liked_movies = MovieLike.where(user_id: user_id).to_a
                          .map { |movie_like| movie_like.movie_id }
    friend_liked_movies = MovieLike.where(user_id: friend_id).to_a
                          .map { |movie_like| movie_like.movie_id }
    user_liked_movies & friend_liked_movies
  end
end
