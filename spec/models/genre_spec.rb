require 'rails_helper'

RSpec.describe Genre, type: :model do
  before do
    @genre = FactoryBot.build(:genre)
  end

  describe 'ジャンルの保存' do
    context 'ジャンルが保存できる場合' do
      it 'ジャンル名が入力されているとき投稿できる' do
        expect(@genre).to be_valid
      end
    end
    context 'ジャンルが保存できない場合' do
      it 'ジャンル名が空では投稿できない' do
        @genre.genre_name = ""
        @genre.valid?
        expect(@genre.errors.full_messages).to include("Genre name can't be blank")
      end     
      it 'ユーザーが紐付いていなければ投稿できない' do
        @genre.user = nil
        @genre.valid?
        expect(@genre.errors.full_messages).to include("User must exist")
      end
    end
  end
end
