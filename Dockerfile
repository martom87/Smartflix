FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /Smartflix
WORKDIR /Smartflix
COPY Gemfile /Smartflix/Gemfile
COPY Gemfile.lock /Smartflix/Gemfile.lock
RUN bundle install
COPY . /Smartflix
