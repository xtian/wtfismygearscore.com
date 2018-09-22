# WTF is My Gear Score?

[![Build Status](https://drone.xtian.us/api/badges/xtian/wtfismygearscore.com/status.svg)](https://drone.xtian.us/xtian/wtfismygearscore.com) [![Code Climate](https://codeclimate.com/github/xtian/wtfismygearscore.com/badges/gpa.svg)](https://codeclimate.com/github/xtian/wtfismygearscore.com)

As described on the site:

> **WTF is My Gear Score?** is an online implementation of the formula from the popular yet oft-maligned GearScore addon for World of Warcraft, which quantifies the quality of a character's gear. We use the scores calculated to rank the top characters by region and realm.

This project is a rewrite of the original PHP codebase.

## Setup

First, install [Homebrew](http://brew.sh).

Then:

```
bin/setup
```

If you are not using Homebrew, you will need to manually install Postgres and Redis and then run `bin/rails db:setup db:migrate`

## Starting the app

First, make sure Postgres and Redis are running.

Then:

```
foreman start
```

and visit `http://127.0.0.1:3000`

## Running the tests

```
bin/rspec
bin/rake rubocop
bin/rake eslint:run
bin/rake scss_lint
```

## Documentation

Documentation is written using [Yard](http://yardoc.org) in Markdown format. Use this command to run a server hosting the generated HTML docs:

```
bin/yard server -r
```

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md)
