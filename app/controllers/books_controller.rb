class BooksController < ApplicationController
  before_action :authenticate_user!, 
    only: [:index, :new, :create, :destroy, :trash, :trashes_box, :recover_from_trashbox]

  def index
    @books = Book.where(user_id: current_user.id,is_deleted: false)
    @book_image_url = []
    @books.each do |book|
      book_data = RakutenWebService::Books::Book.search(title: book.book_subject)
      if book_data.count == 0
        @book_image_url << nil
      else
        book_data.each_with_index do |book_url,i|
          if i == 0 
            book_url_a_data = book_url.large_image_url
            @book_image_url << book_url_a_data
          end
        end
      end
    end
  end

  def new
    @book = Book.new
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
      render :new
    end
  end

  def create
    binding.pry
    @book = Book.new(book_params)
    if @book.save
      flash[:success_book_registration] = CREATE_BOOK_SUCCESS
      redirect_to root_path
    else  
      flash.now[:error_book] = CREATE_BOOK_VALIDATION_ERROR
      render :new
    end
  end

  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end



  def destroy
    ActiveRecord::Base.transaction do
      book = Book.find(params[:id])
      if book.valid?
        book.destroy
        flash[:success_book_destroy] = BOOK_DESTROY_SUCCESS
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
        flash[:success_book_trash] = BOOK_TRUSH_SUCCESS
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
