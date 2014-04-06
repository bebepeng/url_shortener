require './app'
require 'sequel'

URL_DATABASE = Sequel.connect('postgres://gschool_user:gschool_user@localhost:5432/url_database')
run App