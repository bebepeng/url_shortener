require 'sinatra/base'
require './lib/url_repository'
require './lib/url_validator'
require './lib/pad_url'

class App < Sinatra::Application

  LINKS_REPO = UrlRepository.new(DB)

  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    url = PadUrl.call(params[:url])
    vanity = params[:vanity]
    url_validation_result = UrlValidator.new(url).validate
    if url_validation_result.validity && !LINKS_REPO.has_vanity?(vanity)
      identification = LINKS_REPO.insert(url, vanity)
      puts "Identification is #{identification}"
      redirect "/#{identification}?stats=true"
    else
      if LINKS_REPO.has_vanity?(vanity) && !vanity.empty?
        error = 'That vanity is already taken'
      else
        error = url_validation_result.error
      end
      session[:message] = error
      redirect '/'
    end
  end

  get '/:id' do
    id = params[:id]
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
