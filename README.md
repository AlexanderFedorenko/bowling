# Bowling scoring app
[Working demo](http://bowling.fedorenko.im/)

Helps count single score for player bowling game (aka Ten-pin bowling)

## Prerequisites

App runs on latest Ruby verson 2.3.0
To get one `run rvm install 2.3.0`

## Installation

* `git clone <repository-url>` this repository
* change into the new directory
* `bundle install --without production`
* `rake db:create`
* `rake db:schema:load`

## Running / Development

* `rails s`
* visit your app at [http://localhost:3000](http://localhost:3000)

### Running Tests

At the moment application has no tests
You can help by writing some

### Deploying

Specify what it takes to deploy your app

## Further Reading / Useful Links

* [Ruby Version Manager (RVM)](https://rvm.io/)
* [Ruby on Rails Guides](http://guides.rubyonrails.org/index.html)
* [Ten-pin bowling description](https://en.wikipedia.org/wiki/Ten-pin_bowling)

Picture for logo was taken from [WorldArtsMe](http://worldartsme.com/bowling-strike-clipart.html)