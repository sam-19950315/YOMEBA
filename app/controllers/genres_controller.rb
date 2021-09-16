class GenresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success_genre] = CREATE_GENRE_SUCCESS
      redirect_to root_path
    else
      flash.now[:error_genre] = CREATE_GENRE_VALIDATION_ERROR
      render :new
    end
  end

  private
  def genre_params
    params
    .require(:genre)
    .permit(:genre_name)
    .merge(user_id: current_user.id)
  end

end
