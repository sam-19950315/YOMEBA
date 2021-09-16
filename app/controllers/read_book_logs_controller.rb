class ReadBookLogsController < ApplicationController
  require "date"
  before_action :authenticate_user!, only: [:create, :index, :genre_ranking, :graph]

  DEFAULT_BOOK_LOG_NUM = 5
  DEFAULT_GENRE_RANK_NUM = 5
  BOOL_LOG_PERIOD = 30


  def create
    ReadBookLog.create(
      user_id: current_user.id, 
      book_id: params[:id], 
      log: Date.today
    )
    redirect_to books_path
  end

  def index
    @read_book_logs = Book
    .joins(:read_book_logs)
    .joins(:genre)
    .where(user_id: current_user.id)
    .group("books.book_subject")
    .group("genres.genre_name")
    .order('count_all DESC')
    .count
    .first(DEFAULT_BOOK_LOG_NUM)
  end

  def genre_ranking
    @read_book_logs = Book
    .joins(:read_book_logs)
    .joins(:genre)
    .where(user_id: current_user.id)
    .group("genres.genre_name")
    .order('count_all DESC')
    .count
    .first(DEFAULT_GENRE_RANK_NUM)
  end

  def graph
    @datas = ReadBookLog
    .where(user_id: current_user.id)
    .select(:log)
    .group("read_book_logs.log")
    .count
    .first(BOOL_LOG_PERIOD)

  end

end
