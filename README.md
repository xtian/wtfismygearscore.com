# WTF is My Gearscore?

## Setup

First, make sure you have Postgres version 9.5 and Ruby version 2.3.0 installed.

Then:

```
bin/bundle
bin/rails db:setup db:migrate
```

## Starting the app

First, make sure Postgres is running.

Then:

```
bin/guard
```

and visit `http://127.0.0.1:3000`

## Running the tests

```
bin/rspec
bin/rake rubocop
```

## Development

See [CONTRIBUTING.md](https://gitlab.com/closedloops/wtfismygs-rails/blob/master/CONTRIBUTING.md)
