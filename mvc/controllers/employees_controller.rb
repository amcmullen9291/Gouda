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
      erb :home, :layout => false
    end

    get '/bcs/login' do 
      erb :verification, :layout => false
    end

    get '/bcs/registrations' do
      erb :"/profile/new_profile/create", :layout => false
    end

    get "/bcs/login-test" do #HR test
      @session = session
       if params[:breed] == "7" && params[:surface] == "pangram"
        @session[:office] = "YES"
        erb :"hr_profile/show"
       else
          flash[:notice] = "Of all the gin joints in all the towns in all the world, she walks into mine. -Rick Blaine"
          redirect '/bcs/login'
       end
    end

    post '/bcs/new_employee' do
      @employee = Employee.new(params[:employee])
      @employee.save

      @session = session
      @session[:id] = @employee.id
      @session[:badge_id] = @employee.badge_id

      flash[:notice] = "New Profile Created."

      erb :"profile/new_profile/show"
    end
#------------ first route wwith a symbol--------->
    get '/bcs/profile/:badge_id' do 
      @session = session
      @employee = Employee.find_by(:badge_id => params[:employee][:badge_id])
      if @employee && @employee.authenticate(params[:employee][:password])
        @session[:badge_id] = params[:employee][:badge_id]
        @session[:last_name] = @employee[:last_name]
        @session[:id] = @employee[:id]
        @session[:shift_id] = @employee[:shift_id]
        @session[:first_name] = @employee[:first_name]
        @session[:dept_id] = @employee[:dept_id]
        @session[:email] = @employee[:email]
        @session[:telephone] = @employee[:telephone]
        @session[:password] = @employee[:password]
        redirect '/bcs/profile/:badge_id/hours'  #redirect to Hours controller
      else
        flash[:notice] = "Password or Badge ID not recognized. Please try again"
        flash[:notice]
        redirect '/bcs/login'
      end
    end
end