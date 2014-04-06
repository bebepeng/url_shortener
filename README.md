URL Shortener

#Project URLs

Tracker Project:
https://www.pivotaltracker.com/n/projects/1047372

Staging environment:
http://sheltered-chamber-7594.herokuapp.com

Production environment:
http://sheltered-shore-2572.herokuapp.com

#Welcome

The URL shortener allows the user to shorten URLs for readability and easier sharing
on social media.

#Getting Started

1. Fork/clone repository

2. Create databases by running `createdb -U gschool_user url_database` and `createdb - U gschool_user url_database_test`

2. Run Bundler by typing `bundle install`

Bundler will download and install the required gems to run the URL shortener

4. run `sequel -m db/migrate postgres://gschool_user:gschool_user@localhost:5432/url_database_test`

3. run `rake db:migrate`

4. Run test suite by typing `rspec`

The tests are written in Capybara and RSpec

5. Type `rerun rackup` to initiate the local server

Rerun is a gem that will automatically restart the local server each time a change
is made.

Rackup is a gem that will run the local server.

For more information on gems please visit http://rubygems.org