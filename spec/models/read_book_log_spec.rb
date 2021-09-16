require 'rails_helper'

RSpec.describe ReadBookLog, type: :model do
  before do
    @read_book_log = FactoryBot.build(:read_book_log)
  end

  describe 'Logの保存' do
    context 'Logが保存できる場合' do
      it 'Logに日付が入力されているとき投稿できる' do
        expect(@read_book_log).to be_valid
      end
    end
    context 'Logが保存できない場合' do
      it 'Logが空では投稿できない' do
        @read_book_log.log = ""
        @read_book_log.valid?
        expect(@read_book_log.errors.full_messages).to include("Log can't be blank")
      end     
      it 'ユーザーが紐付いていなければ投稿できない' do
        @read_book_log.user = nil
        @read_book_log.valid?
        expect(@read_book_log.errors.full_messages).to include("User must exist")
      end
      it '本が紐付いていなければ投稿できない' do
        @read_book_log.book = nil
        @read_book_log.valid?
        expect(@read_book_log.errors.full_messages).to include("Book must exist")
      end
    end
  end
end
