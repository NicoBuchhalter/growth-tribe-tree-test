Trees API - Growth Tribe Interview Task
===============

[API Documentation](/docs/api.md)
---------------


## Running local server

### 1- Installing Ruby

- Clone the repository by running `git clone git@github.com:NicoBuchhalter/tree-test.git`
- Go to the project root by running `cd tree-test`
- Download and install [Rbenv](https://github.com/rbenv/rbenv#basic-github-checkout).
- Download and install [Ruby-Build](https://github.com/rbenv/ruby-build#installing-as-an-rbenv-plugin-recommended).
- Install the appropriate Ruby version by running `rbenv install [version]` where `version` is the one located in [.ruby-version](.ruby-version)

### 2- Installing Rails gems

- Install [Bundler](http://bundler.io/).

```bash
  gem install bundler
  rbenv rehash
```

- Install all the gems included in the project.

```bash
  bundle install
```

### 3- Database Setup

- Run in terminal:

```bash
  psql postgres
  CREATE ROLE "tree_test" LOGIN CREATEDB PASSWORD 'tree_test';
```

- Log out from postgres and run:

```bash
  bundle exec rake db:create db:migrate
```

### 4- Add Master Key
	
- You should have been provided with a master key. Create the file `/cofig/master.key` and place it inside.

### 5- Install Redis and start Sidekiq (Optional)

- Download and install [Redis](https://redis.io/topics/quickstart)
- Run in a terminal: 

```bash
	bundle exec sidekiq -c 5 -v
```

### 6- Fetch Tree
	
- Run in a terminal:

```bash
	rake fetch_tree:now
```

- If you want to do it in an async way (you need to have Sidekiq running in other terminal):

```bash
	rake fetch_tree:async
```

### 7- Start Server

```bash
	rails server
```

## Deploying to Heroku

### 1- Login and create Heroku app

- Install [Heroku Cli](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
- Run in terminal:

```bash
	heroku login
	heroku create <your-desired-app-name>
```

### 2- Deploy 

```bash
	git push heroku master
```

### 3- Install Redis and enable worker (Optional)

- Go to Heroku dashboard and add Redis Resource (Heroku Redis or any other)
- Enable the worker dyno

### 4- Load Master Key

- You should have been provided with a Master key.
- Run in terminal:

```bash
	heroku config:set RAILS_MASTER_KEY=<master-key>
```

### 5- Fetch Tree

- You can run it in the heroku server directly:

```bash
	heroku run rake fetch_tree:now
```

- Or, if you configured Sidekiq, you can run it async:

```bash
	heroku run rake fetch_tree:async
```

## About

This project is maintained by [Nicolas Buchhalter](https://github.com/NicoBuchhalter)