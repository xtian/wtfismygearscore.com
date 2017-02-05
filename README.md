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

If you are using Windows this will not work and you are on your own. Good luck!

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

### Mutation tests

To ensure complete test coverage for a class, you can run mutation tests with [mutant](https://github.com/mbj/mutant):

```
RAILS_ENV=test bin/mutant -r ./config/environment --use rspec ClassName
```

## Documentation

Documentation is written using [Yard](http://yardoc.org) in Markdown format. Use this command to run a server hosting the generated HTML docs:

```
bin/yard server -r
```

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md)
