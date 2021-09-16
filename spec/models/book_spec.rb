require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
  end

  describe '本の保存' do
    context '本が保存できる場合' do
      it '本のタイトル、ジャンルが入力されているとき投稿できる' do
        expect(@book).to be_valid
      end
    end
    context '本が保存できない場合' do
      it '本のタイトルが空では投稿できない' do
        @book.book_subject = ""
        @book.valid?
        expect(@book.errors.full_messages)
          .to include("Book subject can't be blank")
      end     
      it 'ジャンル名が空では投稿できない' do
        @book.genre = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("Genre must exist")
      end   

      it 'ユーザーが紐付いていなければ投稿できない' do
        @book.user = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("User must exist")
      end
    end
  end
end
