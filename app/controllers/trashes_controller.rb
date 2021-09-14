class TrashesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :trash_reverse]

  def index
    @books = Book.where(user_id: current_user.id, is_deleted: true)
  end

  def reverse
    book = Book.find(params[:id])
    book.update(is_deleted: false)
    redirect_to root_path
  end
end
