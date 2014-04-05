require 'sinatra/base'
require 'sequel'
require './lib/url_repository'
require './lib/url_validator'

class App < Sinatra::Base

  URL_DATABASE = Sequel.connect('postgres://gschool_user:gschool_user@localhost:5432/url_database')
  URL_DATABASE.create_table! :urls do
    primary_key :id
    String :original_url
    Integer :visits, :default => 0
  end
  URL_TABLE = URL_DATABASE[:urls]
  LINKS_REPO = UrlRepository.new(URL_TABLE)
  ERROR_INVALID = "The text you entered is not a valid URL."
  ERROR_BLANK = "The URL cannot be blank."

  enable :sessions

  get '/' do
    @domain = request.url
    erb :index
  end

  post '/' do
    url = params[:url]
    url_to_shorten = UrlValidator.new(url)
    if url_to_shorten.url_is_valid?
      url = url_to_shorten.create_usable_url
      id = LINKS_REPO.insert(url)
      redirect "/#{id}?stats=true"
    elsif url.empty?
      session[:message] = ERROR_BLANK
      redirect '/'
    else
      session[:message] = ERROR_INVALID
      redirect '/'
    end
  end

  get '/:id' do
    id = params[:id].to_i
    old_url = LINKS_REPO.get_url(id)
    if params[:stats]
      erb :show_stats, :locals => {:old_url => old_url,
                                   :id => id,
                                   :visit_count => LINKS_REPO.get_visits(id), :domain => @domain}
    else
      LINKS_REPO.add_visit(id)
      redirect LINKS_REPO.get_url(id)
    end
  end
end
