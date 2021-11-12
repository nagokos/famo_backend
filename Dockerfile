FROM ruby:3.0.0

RUN apt-get update -qq && \
    apt-get install -y build-essential \
    libpq-dev \
    nodejs \
    mariadb-client \
    vim  \
    && rm -rf /var/lib/apt/lists/* 

RUN mkdir /myapp
WORKDIR /myapp

RUN mkdir -p tmp/pids
RUN mkdir -p tmp/sockets

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install
COPY . /myapp

VOLUME /myapp/public
VOLUME /myapp/tmp

CMD bundle exec puma -C config/puma.rb