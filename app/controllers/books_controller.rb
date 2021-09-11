class BooksController < ApplicationController

  def index
    @books = Book.where(user_id: current_user.id)
  end

  def new
    @book = Book.new

  end

  def create
    book = Book.create(book_params)
    redirect_to root_path
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to root_path
  end

  private
  def book_params
    params.require(:book).permit(:book_subject,:genre_id).merge(user_id: current_user.id)
  end
  
end
