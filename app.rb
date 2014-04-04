require 'sinatra/base'
require './lib/url_repository'
require './lib/url_shortener'

class App < Sinatra::Base

  LINKS_REPO = UrlRepository.new
  ERROR_INVALID = "The text you entered is not a valid URL."
  ERROR_BLANK = "The URL cannot be blank."

  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    id = LINKS_REPO.urls.count + 1
    url = params[:url]
    url_to_shorten = UrlShortener.new(id, url)
    if url_to_shorten.url_is_valid?
      LINKS_REPO.urls << url_to_shorten
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
    url_hash = LINKS_REPO.urls[id-1].url_hash
    if params[:stats]
      erb :show_stats, :locals => {:old_url => url_hash[:old_url],
                                   :id => url_hash[:id],
                                   :visit_count => url_hash[:total_visits]}
    else
      url_hash[:total_visits] += 1
      redirect LINKS_REPO.urls[(params[:id].to_i) - 1].url_hash[:old_url]
    end
  end
end
