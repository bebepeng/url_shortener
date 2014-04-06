require 'sinatra/base'
require './lib/url_repository'
require './lib/url_validator'

class App < Sinatra::Application

  LINKS_REPO = UrlRepository.new(DB)

  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    url = params[:url]
    url_to_shorten = UrlValidator.new(url)
    if url_to_shorten.url_is_valid?
      url = url_to_shorten.create_usable_url
      id = LINKS_REPO.insert(url)
      redirect "/#{id}?stats=true"
    else
      session[:message] = url_to_shorten.error
      redirect '/'
    end
  end

  get '/:id' do
    id = params[:id].to_i
    old_url = LINKS_REPO.get_url(id)
    if params[:stats]
      erb :show_stats, :locals => {:old_url => old_url,
                                   :id => id,
                                   :visit_count => LINKS_REPO.get_visits(id),
                                   :domain => request.host_with_port}
    else
      LINKS_REPO.add_visit(id)
      redirect LINKS_REPO.get_url(id)
    end
  end
end
