require 'rails_helper'

RSpec.describe "本のlogが取れる", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @genre = Faker::Lorem.sentence
    @book = Faker::Lorem.sentence
  end
  context '本のlogが取れる' do 
    it 'プラスボタンを押せば、read_book_logのレコードが増える。そして、グラフ、ランキングに反映される' do
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
      visit read_book_logs_path
      expect(page).to have_content("#{@book}")
      visit index_genre_ranking_path
      expect(page).to have_content("#{@genre}")
    end
  end
end