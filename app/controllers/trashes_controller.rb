class TrashesController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!, only: [:index, :reverse]
=======
  before_action :authenticate_user!, only: [:index, :trash_reverse]
>>>>>>> parent of 571cf31 (Merge pull request #25 from sam-19950315/バグ修正)

  def index
    @books = Book.where(user_id: current_user.id, is_deleted: true)
  end

  def reverse
    book = Book.find(params[:id])
    book.update(is_deleted: false)
    redirect_to root_path
  end
end
