

# Wunder Battle Pets Arena API

This API allows users to pit their Battle Pets against one another in various forms of combat.

## Getting Started

This is a Rails 5 app, so make sure you are running a recent version of Ruby:

```rvm use -v 2.3.1```

and then make sure your rails is up-to-date:

```bundle update rails```

Set up all the gems:

```bundle install```

and then spin up the database:

```
rake db:create
rake db:migrate
rake db:seed
```

At this point you should be able to run the app:

```rails s```

and then the API will be available at [http://localhost:3000](http://localhost:3000)

## Running Tests

This app uses RSpec for testing, so to make sure everything is working as expected run:

```bundle run rspec```

## Quick Demo

There are a few rake tasks set up to display how the API functions:

```rake demo:battle_demo```

will set use a pair of already provisioned Battle Pets and show the results of both a turn-based and a pure stats comparison type of combat.

