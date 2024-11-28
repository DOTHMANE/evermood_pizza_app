FROM ruby:3.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /evermood_pizza_app
WORKDIR /evermood_pizza_app
ADD Gemfile /evermood_pizza_app/Gemfile
ADD Gemfile.lock /evermood_pizza_app/Gemfile.lock
RUN bundle install
ADD . /evermood_pizza_app
