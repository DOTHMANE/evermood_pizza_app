# README

This project contains the Evermood pizza app. This is a Ruby on Rails 7 project.

You need:
* Docker & docker-compose
* Ruby 3.3.0

## Build the environment

  ```sh
  docker-compose build
  ```

## Database creation

  ```sh
  docker-compose run backend bundle exec rake db:setup
  ```

## Start the environment

  ```sh
  docker-compose up
  ```

## Working with the Rails container

  ```sh
  docker-compose exec backend bash
  ```

## Tests

  ```sh
  rspec
  ```

