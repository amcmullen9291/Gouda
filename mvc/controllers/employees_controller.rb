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

    post '/bcs/profile/:badge_id/new_hours' do 
      @session = session
      @day= "Sunday" #only here so profile re-populates date
      @date = Hour.new 
      @week =  @date.date_of_next(@day)

      Hour.connection #unneeded now that config is aware...
      daily = Date.new
      @counter = params[:counter]
      @shift =  daily.cwday  
      @logged_time = params[:time] 

      @newhours = Hour.find_by(:id => @session[:hours_id])
      @newhours.update(params[:hours]) 
      @newhours.timecard(@counter, @shift, @logged_time)
      @counter = @counter.to_i
      @counter +=1
      @counter = @counter.to_s
      if @counter == "3"
          @counter.revert
      end 
      @newhours[:counter] = @counter
      @newhours.save  

      @d = Time.now #for params[:time]
      flash[:notice] =  "Time Card has been Updated." 
      erb :'/profile/show'
    end
      
    delete '/bcs/profile/:id/reset' do # A new Week Class instance progression
        @hours = Hour.find(:id => @session[:hour_id])
        # @hours = Employee.hour
        # @weeks = Employee.left_outer_joins(:hour)
        @hours.destroy
        flash[:notice] = "Time Card Submitted. Thank You." #flash wont pass through 2nd route
        redirect "/bcs/profile/:badge_id/hours"
    end
end