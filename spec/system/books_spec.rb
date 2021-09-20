require 'rails_helper'

RSpec.describe "本の登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
    @book = Faker::Lorem.sentence
  end
  context '本が登録できる' do 
    it 'サインインしており、正しい情報を入力すれば本の登録ができてトップページに移動する' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      click_link '本の登録'
      expect(current_path).to eq(new_book_path)
      fill_in 'book_book_subject', with: @book
      select "#{@genre}", from: "book_genre_id"
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('本の登録に成功しました')
    end
  end
  context '本が登録できない' do
    it 'ジャンル名の選択がなければ、本の登録ができずに新規登録ページへ戻ってくる' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      click_link '本の登録'
      expect(current_path).to eq(new_book_path)
      fill_in 'book_book_subject', with: @book
      find('input[name="commit"]').click
      expect(current_path).to eq(books_path)
      expect(page).to have_content('タイトル、ジャンルは必須です。')
    end
    it 'サインしていなければ、本の登録ができずにログインページに遷移する' do
      visit root_path
      click_link '本の登録'
      expect(current_path).to eq(new_user_session_path)
      expect(page)
        .to have_content('You need to sign in or sign up before continuing.')
    end
  end
end


RSpec.describe "本の一覧表示", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
    @book = Faker::Lorem.sentence

  end
  context '登録した本が一覧表示される' do 
    it '本が登録されていれば、登録した本が一覧表示される' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      click_link '本の登録'
      fill_in 'book_book_subject', with: @book
      select "#{@genre}", from: "book_genre_id"
      find('input[name="commit"]').click
      click_link '本棚'
      expect(current_path).to eq(books_path)
      expect(page).to have_content("#{@book}")
    end
  end
  context '新しい本を登録しよう！と表示される' do 
    it '本が登録されていなければ、新しい本を登録しよう！と表示される' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '本棚'
      expect(page).to have_content("1冊目の本を 登録しよう！")
      expect(current_path).to eq(books_path)
    end
  end
end


RSpec.describe "本の完全削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
    @book = Faker::Lorem.sentence
  end
  context '本が完全削除できる' do 
    it '完全削除のボタンを押せば、本の削除ができてトップページに移動する' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      click_link '本の登録'
      fill_in 'book_book_subject', with: @book
      select "#{@genre}", from: "book_genre_id"
      find('input[name="commit"]').click
      click_link '本棚'
      click_link '完全削除'
      expect(page).to have_content('完全削除しました')
      expect(current_path).to eq(root_path)
    end
  end
end


RSpec.describe "本の論理削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
    @book = Faker::Lorem.sentence
  end
  context '本が論理削除できる' do 
    it 'ゴミ箱ボタンを押せば、本の論理削除ができてトップページに移動する' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      click_link '本の登録'
      fill_in 'book_book_subject', with: @book
      select "#{@genre}", from: "book_genre_id"
      find('input[name="commit"]').click
      click_link '本棚'
      click_link 'ゴミ箱に移動'
      expect(page).to have_content('ゴミ箱への移動に成功しました')
      expect(current_path).to eq(root_path)
    end
  end
end


RSpec.describe "本の復活", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
    @book = Faker::Lorem.sentence
  end
  context '本の復活ができる' do 
    it '復活ボタンを押せば、本を復活でき、トップページに移動する' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      click_link '本の登録'
      fill_in 'book_book_subject', with: @book
      select "#{@genre}", from: "book_genre_id"
      find('input[name="commit"]').click
      click_link '本棚'
      click_link 'ゴミ箱に移動'
      click_link 'ゴミ箱'
      click_link '復活'
      click_link '本棚'
      expect(page).to have_content("#{@book}")
    end
  end
end


RSpec.describe "本のカウントができる", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
    @book = Faker::Lorem.sentence
  end
  context '本のカウントができる' do 
    it 'プラスボタンを押せば、book_indexページの本の下の数字が1増える' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link '新規ジャンル'
      fill_in 'genre_genre_name', with: @genre
      find('input[name="commit"]').click
      click_link '本の登録'
      fill_in 'book_book_subject', with: @book
      select "#{@genre}", from: "book_genre_id"
      find('input[name="commit"]').click
      click_link '本棚'
      click_link 'プラスボタン'
      expect(page).to have_content("1")
      expect(current_path).to eq(books_path)
    end
  end
end