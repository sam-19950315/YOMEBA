class ReadBookLogsController < ApplicationController
  def create
    ReadBookLog.create(user_id: current_user.id, book_id: params[:id])
    redirect_to books_path
  end
end
