require 'sinatra/flash'
require 'rack-flash'

class EmployeesController < Sinatra::Base
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
        "No more games!"
    end
end