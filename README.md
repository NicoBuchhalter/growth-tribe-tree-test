Trees API - Growth Tribe Interview Task
===============

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


## About

This project is maintained by [Nicolas Buchhalter](https://github.com/NicoBuchhalter)