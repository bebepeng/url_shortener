require 'sequel'
require 'dotenv'

Dotenv.load

if !ENV['HEROKU_POSTGRESQL_BRONZE_URL'].nil?
  DB=Sequel.connect(ENV['HEROKU_POSTGRESQL_BRONZE_URL'])
else
  DB = Sequel.connect(ENV['DATABASE_URL'])
end

require './app'

run App
