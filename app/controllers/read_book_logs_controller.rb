class ReadBookLogsController < ApplicationController
  def create
    ReadBookLog.create(user_id: current_user.id, book_id: params[:id])
    redirect_to books_path
  end

  def book_ranking
    @books_data = Book.where(user_id: current_user.id)
    books_count = []
    @books_data.each do |book|
      books_count_detail = []
      books_count_detail << book.read_book_logs.count
      books_count_detail << book.book_subject
      books_count_detail << book.genre_id
      books_count << books_count_detail
    end
    @books = books_count.sort.reverse
    @genre = Genre.all
  end


  
end
