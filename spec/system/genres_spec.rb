require 'rails_helper'

RSpec.describe "genreの登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
  end
  context 'genreが登録できる' do 
    it 'サインインしており、正しい情報を入力すればgenre登録ができてトップページに移動する' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      expect(current_path).to eq(new_genre_path)
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ジャンルが登録出来ました')
    end
  end
  context 'genreが登録できない' do
    it 'ジャンル名が空ではジャンル登録ができずに新規登録ページへ戻ってくる' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      expect(current_path).to eq(new_genre_path)
      fill_in 'genre_genre_name', with: ""
      find('input[name="commit"]').click
      expect(current_path).to eq(genres_path)
      expect(page).to have_content('ジャンルの内容は必須です。')
    end
    it 'サインしていなければ、ジャンル登録ができずにログインページに遷移する' do
      visit root_path
      click_link '新規ジャンル'
      expect(current_path).to eq(new_genre_path)
      expect(page).to have_content('ログイン')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
