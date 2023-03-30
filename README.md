# README

### Requirements

* Ruby 3.0.1
* Rails 6.1.4
* PostgreSQL
* Redis

### Installation

* `bundle install`
* `bundle exec rails db:create db:migrate db:seed`

### Run Server

* `foreman start -f Procfile.dev`

Open browser and go to [http://localhost:3000](http://localhost:3000)
Sidekiq web go to [http://localhost:3000/sidekiq](http://localhost:3000/sidekiq)
