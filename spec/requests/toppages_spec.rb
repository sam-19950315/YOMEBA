require 'rails_helper'

RSpec.describe "Toppages", type: :request do

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに本棚に遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/books\">本棚")
    end
    it 'indexアクションにリクエストするとレスポンスに本の登録ページに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/books/new\">本の登録")
    end
    it 'indexアクションにリクエストするとレスポンスに新規ジャンル作成に遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/genres/new\">\n          新規ジャンル")
    end
    it 'indexアクションにリクエストするとレスポンスにグラフに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/read_book_log_graph\">グラフ")
    end
    it 'indexアクションにリクエストするとレスポンスに読んだ絵本ランキングに遷移するリンクが存在する' do
      get root_path
      expect(response.body).to include("href=\"/read_book_logs\">\n          読んだ絵本") 
    end
    it 'indexアクションにリクエストするとレスポンスに読んだジャンルランキングに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/read_book_log\">\n          読んだジャンル")
    end
    it 'indexアクションにリクエストするとレスポンスにゴミ箱に遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/book_trashes_box\">ゴミ箱")
    end
    it 'indexアクションにリクエストするとログインページに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/users/sign_in\">ログイン")
    end
    it 'indexアクションにリクエストするとレスポンスにサインアップページに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/users/sign_up\">サインアップ")
    end
    it 'indexアクションにリクエストするとレスポンスにアプリのroot_pathに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("href=\"/\">YOMEBA")
    end
  end
end
