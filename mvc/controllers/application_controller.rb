require 'sinatra/base'
require 'sinatra/flash'
require 'rack-flash'

require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'mvc/views' 
        set :sessions => true
        set :session_secret, '0cd545040d'
        register Sinatra::Flash
        use Rack::Flash, :accessorize => [:notice, :error]
      end

      get '/' do
        @session = session
        session.clear
        erb :home, :layout => false
      end
end