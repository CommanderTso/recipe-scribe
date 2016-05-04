README
==

[ ![Codeship Status for CommanderTso/recipe-scribe](https://codeship.com/projects/7b969140-e727-0133-81da-0eb548e23054/status?branch=master)](https://codeship.com/projects/146859)
[![Code Climate](https://codeclimate.com/github/CommanderTso/recipe-scribe/badges/gpa.svg)](https://codeclimate.com/github/CommanderTso/recipe-scribe)
[![Coverage Status](https://coveralls.io/repos/github/CommanderTso/recipe-scribe/badge.svg?branch=master)](https://coveralls.io/github/CommanderTso/recipe-scribe?branch=master)

What is Recipe Scribe?
---

Recipe Scribe is the "Breakable Toy" project I created in the last two weeks of [Launch Academy](https://launchacademy.com/) - essentially a portfolio piece that integrates most of what I learned in the program.

The app was built to solve a real-world problem: my wife and I spend a good bit of time each weekend creating the food shopping list - choosing our meals for the coming week, writing down what we need, crossing off items we already have, and then resorting the list by store section.

The app lets you select recipes from your library and automatically builds them into a shopping list. It was built with Rails, AJAX, Foundation (with Motion UI animations), Sass, and Google Storage.

Installation instructions
---
To install the app:
* Clone this repository
* `bundle install`
* `rake db:setup`
* Set up API keys (see below)
* `rails s`
* Visit `localhost:3000`

Setting Up API keys
---
Recipe Scribe requires API keys be set up for Google Storage, which is used to store and serve recipe images. The keys must let the app access a bucket to store and serve files. The app is currently set up to expect a `.env` file (using the dotenv gem) in the app root directory, which should contain values for:
* `GOOGLE_ACCESS_KEY`
* `GOOGLE_SECRET_ACCESS_KEY`
* `GOOGLE_BUCKET_NAME`

For a production environment, please reference how your server setup expects to access API keys and secrets.

What is still left to do?
---
In priority order...

* Create the unit tests needed for a number of model methods
* Fix bug where shopping list no longer floats at top of screen
* Create user input for ingredients, including store section / aisle
* User can alter quantities and measurements of items in shopping list
* "Reset" button to clear shopping list
* Sort grocery list items by store section and/or aisle
* Convert UI to React (learning project)
* Make the UI responsive
* Recipe search / filtering
* User can have multiple shopping lists
* Better segmenting of recipe information (add ratings, possibly break out instructions into line items, etc.)
* Account deletion
* Sharing recipes with other accounts
