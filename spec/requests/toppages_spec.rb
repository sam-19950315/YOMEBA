require 'rails_helper'

RSpec.describe "Toppages", type: :request do

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに本棚に遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("本棚")
    end
    it 'indexアクションにリクエストするとレスポンスに本の登録ページに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("本の登録")
    end
    it 'indexアクションにリクエストするとレスポンスに新規ジャンル作成に遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("新規ジャンル")
    end
    it 'indexアクションにリクエストするとレスポンスにグラフに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("グラフ")
    end
    it 'indexアクションにリクエストするとレスポンスに読んだ絵本ランキングに遷移する
      リンクが存在する' do
      get root_path
      expect(response.body).to include("読んだ絵本") 
    end
    it 'indexアクションにリクエストするとレスポンスに読んだジャンルランキングに
      遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("読んだジャンル")
    end
    it 'indexアクションにリクエストするとレスポンスにゴミ箱に遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("ゴミ箱")
    end
    it 'indexアクションにリクエストするとログインページに遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("ログイン")
    end
    it 'indexアクションにリクエストするとレスポンスにサインアップページに
      遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("サインアップ")
    end
    it 'indexアクションにリクエストするとレスポンスにアプリのroot_pathに
      遷移するリンクが存在する' do 
      get root_path
      expect(response.body).to include("YOMEBA")
    end
  end
end
