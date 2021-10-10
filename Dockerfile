FROM ruby:3.0.0
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && curl -sL https://deb.nodesource.com/setup_14.x  | bash - \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /myapp \
    && apt-get install -y mariadb-client \
    && apt-get install -y vim

WORKDIR /myapp
RUN mkdir -p tmp/pids
RUN mkdir -p tmp/sockets
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY yarn.lock /myapp
COPY package.json /myapp
RUN bundle install
RUN yarn install
COPY . /myapp

RUN bundle exec rails webpacker:install
RUN bundle exec rails webpacker:install:vue
RUN bundle exec rails webpacker:compile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME /myapp/public
VOLUME /myapp/tmp

CMD bundle exec puma -C config/puma.rb