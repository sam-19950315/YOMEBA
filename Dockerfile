FROM ruby:2.6.5

RUN apt-get update && \
apt-get install -y nodejs default-mysql-client vim --no-install-recommends && \
rm -rf /var/lib/apt/lists/*

#アプリ用ディレクトリの作成
RUN mkdir /YOMEBA

#ワークディレクトリを設定
WORKDIR /YOMEBA

#ローカルのGemfileをアプリ用コンテナにコピーする
ADD Gemfile /YOMEBA/Gemfile
ADD Gemfile.lock /YOMEBA/Gemfile.lock

#アプリ用コンテナにgemをインストール
RUN gem install bundler
RUN bundle install

#ローカルのアプリファイルをまるっとアプリ用コンテナにコピー
ADD . /YOMEBA