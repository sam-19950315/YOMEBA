require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      visit root_path
      expect(page).to have_content('サインアップ')
      visit new_user_registration_path
      fill_in 'Email', with: @user.email
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_no_content('サインアップ')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit root_path
      expect(page).to have_content('サインアップ')
      visit new_user_registration_path
      fill_in 'Email', with: ""
      fill_in 'Nickname', with: ""
      fill_in 'Password', with: ""
      fill_in 'Password confirmation', with: ""
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_no_content('サインアップ')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      find('input[name="commit"]').click
      expect(current_path).to eq(new_user_session_path)
    end
  end
end


RSpec.describe 'ログアウト', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログアウトができる' do
    it 'topページのログアウトボタンを押せばばログインができる' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link 'ログアウト'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('サインアップ')
      expect(page).to have_content('ログイン')
      expect(page).to have_no_content('ログアウト')
    end
  end
end

RSpec.describe 'ユーザー情報編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '編集ができる' do
    it '正しいパスワードが入力されていれば、編集ができる' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link "#{@user.nickname}さんのプロフィール画像"
      expect(current_path).to eq(edit_user_registration_path)
      fill_in 'Nickname', with: "samyan"
      fill_in 'Current password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
    end
  end
  context '編集が出来ない' do
    it '誤ったパスワードだと、編集ができない' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link "#{@user.nickname}さんのプロフィール画像"
      expect(current_path).to eq(edit_user_registration_path)
      fill_in 'Nickname', with: "samyan"
      fill_in 'Current password', with: "111111"
      find('input[name="commit"]').click
      expect(current_path).to eq(user_registration_path)
      expect(page).to have_content('Current password is invalid')
    end
  end
end

RSpec.describe '退会をする', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '退会ができる' do
    it 'ユーザー情報編集ページで退会ボタンをおすと、退会ができる' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      click_link "#{@user.nickname}さんのプロフィール画像"
      expect(current_path).to eq(edit_user_registration_path)
      click_button 'Cancel my account'
      page.accept_confirm "Are you sure?"
      expect(current_path).to eq(root_path)
      expect(page)
        .to have_content('Bye! Your account has been successfully cancelled. ')
    end
  end
end

