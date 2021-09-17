# YOMEBA
絵本の記録・集計アプリ
## test-user-account
ID:test@gmail.com
Pass:password
# 本アプリ作成への想い
## 目的
親の考える理想の子育てにマッチする絵本を提案することで、子どもの教育に貢献する。
## ターゲット
0歳〜5歳の子どもを持つ保護者
## ターゲットの抱える課題
子どもの興味関心に合わせて、次に何の本を購入すればよいかの検討材料を提示する。
# 開発環境
* 使用言語:ruby (version:2.6.5)
* DB:Mysql(ver:5.6.51)
* フレームワーク:Ruby on Rails(version:6.0.4)
* 仮想空間:Docker
* OS:AmazonLinux2
* プロジェクト管理:git
* テスト:Rspec,capybara
* エディタ:VSCode
# Local環境構築手順(仮想空間Dockerによる)
* ローカルにGitからコードをクローン
* gitからクローンしたディレクトリにて、下記作業を行う
* docker-compose build
* docker-compose run web rails db:create
* docker-compose run web rails webpacker:install 
* docker-compose up -d
