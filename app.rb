require 'sinatra/base'
require './lib/url_repository'
require './lib/url_validator'
require './lib/pad_url'
require './lib/vanity_error'

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
    vanity_error = VanityError.get_error(vanity)
    if url_validation_result.validity && !LINKS_REPO.has_vanity?(vanity) && vanity_error.empty?
      identification = LINKS_REPO.insert(url, vanity)
      puts "Identification is #{identification}"
      redirect "/#{identification}?stats=true"
    else
      session[:vanity] = vanity
      session[:url] = params[:url]
        if LINKS_REPO.has_vanity?(vanity)
          message_vanity = 'That vanity is already taken'
        else
          message_vanity = vanity_error
        end
      message_url = url_validation_result.error
      session[:message_url] = message_url
      session[:message_vanity] = message_vanity
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
