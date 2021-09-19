FROM ruby:2.6.5
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y nodejs yarn npm \
  && npm install n -g \
  && n 12.13.0 \
  && echo "export PATH=/usr/local/n/versions/node/12.13.0/bin/:$PATH" >> ~/.bashrc \ 
  && source ~/.bashrc
RUN mkdir /YOMEBA
WORKDIR /YOMEBA
COPY Gemfile /YOMEBA/Gemfile
COPY Gemfile.lock /YOMEBA/Gemfile.lock
RUN gem install bundler && bundle install
COPY . /YOMEBA


