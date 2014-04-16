require 'sinatra/base'
require './lib/url_repository'
require './lib/url'
require './lib/shortener_constraints'
require './lib/vanity'

class App < Sinatra::Application

  LINKS_REPO = UrlRepository.new(DB)

  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    url = Url.new(params[:url])
    vanity = Vanity.new(params[:vanity])
    shortener_constraints = ShortenerConstraints.new(url, vanity, LINKS_REPO)

    if shortener_constraints.valid?
      identification = shortener_constraints.save
      redirect "/#{identification}?stats=true"
    else
      session[:vanity] = params[:vanity]
      session[:url] = params[:url]
      session[:message_url] = shortener_constraints.errors[0]
      session[:message_vanity] = shortener_constraints.errors[1]
      redirect '/'
    end
  end

  get '/:identification' do
    identification = params[:identification]
    old_url = LINKS_REPO.get_url(identification)
    if params[:stats]
      erb :show_stats, :locals => {:old_url => old_url,
                                   :id => identification,
                                   :visit_count => LINKS_REPO.get_visits(identification),
                                   :domain => request.host_with_port}
    else
      LINKS_REPO.add_visit(identification)
      redirect LINKS_REPO.get_url(identification)
    end
  end
end
