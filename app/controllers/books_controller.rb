class BooksController < ApplicationController
  before_action :authenticate_user!, 
    only: [:index, :new, :create, :destroy, :trash, :trashes_box, :recover_from_trashbox]

  def index
    @books = Book.where(user_id: current_user.id,is_deleted: false)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to root_path
    else  
      flash.now[:error_book] = CREATE_BOOK_VALIDATION_ERROR
      render :new
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      book = Book.find(params[:id])
      if book.valid?
        book.destroy
        redirect_to root_path
      else
        flash.now[:error_book] = BOOK_INVALID_ERROR
        render :destroy
      end
    end


  end

  def trash
    ActiveRecord::Base.transaction do
      book = Book.find(params[:id])
      if book.valid?
        book.update(is_deleted: true)
        redirect_to root_path
      else
        flash.now[:error_book] = BOOK_INVALID_ERROR
        render :trash
      end
    end
  end

  def trashes_box
    @books = Book.where(user_id: current_user.id, is_deleted: true)
  end

  def recover_from_trashbox
    ActiveRecord::Base.transaction do      
      book = Book.find(params[:id])
      if book.valid?
        book.update(is_deleted: false)
        redirect_to root_path
      else
        flash.now[:error_book] = BOOK_INVALID_ERROR
        render :recover_from_trashbox
      end
    end
  end

  private

  def book_params
    params
    .require(:book)
    .permit(:book_subject,:genre_id,:is_deleted)
    .merge(user_id: current_user.id)
  end
  
end
