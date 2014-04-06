require 'sequel'

ENV['RACK_ENV'] = 'test'

URL_DATABASE = Sequel.connect('postgres://gschool_user:gschool_user@localhost:5432/url_database_test')

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

def the(message)
  yield
end

alias and_the the