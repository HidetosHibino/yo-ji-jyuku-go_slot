FROM ruby:2.7.7
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN bin/rails assets:precompile
RUN mkdir -p tmp/sockets