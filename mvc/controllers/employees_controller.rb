require 'sinatra/base'
require 'sinatra/flash'
require 'rack-flash'

require_relative '../../config/environment'

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
    @session = session
    session.clear
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
      puts "Of all the gin joints in all the towns in all the world, she walks into mine. -Rick Blaine"
      redirect '/bcs/login'
    end
  end

  post '/bcs/new_employee' do
    @employee = Employee.new(params[:employee])
    @employee.save

    @session = session
    @session[:id] = @employee.id
    @session[:badge_id] = @employee.badge_id
    @session[:dept_id] = @employee.dept_id
    @day= "Sunday"
    @date = Hour.new 
    @week =  @date.date_of_next(@day) 

    
    flash[:notice] = "New Profile Created."

    erb :"profile/new_profile/show"
  end
#------------ first route with a symbol--------->
  get '/bcs/profile/:badge_id' do 
    @session = session
    @employee = Employee.find_by(:badge_id => params[:employee][:badge_id])
    if @employee && @employee.authenticate(params[:employee][:password])
      @session[:badge_id] = params[:employee][:badge_id]
      @session[:last_name] = @employee[:last_name]
      @session[:id] = @employee[:id]
      @session[:shift_id] = @employee[:shift_id]
      @session[:first_name] = @employee[:first_name]
      @session[:last_name] = @employee[:last_name]
      @session[:dept_id] = @employee[:dept_id]
      @session[:email] = @employee[:email]
      @session[:telephone] = @employee[:telephone]
      @session[:password] = @employee[:password]
      redirect '/bcs/profile/:badge_id/hours'  #redirect to Hours controller
    else
      puts "Password or Badge ID not recognized. Please try again"
      redirect '/bcs/login'
    end
  end

  get '/bcs/profile/:badge_id/edit' do  
    @session = session
    @employee = Employee.find_by(:id => @session[:id])
    @date = Hour.new
    @day= "Sunday"
    @week =  @date.date_of_next(@day)
    
    erb :"/profile/edit" 
  end 

  post '/bcs/profile/:badge_id/modify' do
    @session = session
    @employee = Employee.find_by(:id => @session[:id])
    @employee.update(params[:employee])
    @employee.save

    @session[:badge_id] = @employee[:badge_id]
    @session[:last_name] = @employee[:last_name]
    @session[:id] = @employee[:id]
    @session[:shift_id] = @employee[:shift_id]
    @session[:first_name] = @employee[:first_name]
    @session[:dept_id] = @employee[:dept_id]
    @session[:email] = @employee[:email]
    @session[:telephone] = @employee[:telephone]
    @session[:password] = @employee[:password]

    @date = Hour.new
    @day= "Sunday"
    @week =  @date.date_of_next(@day)

    @newhours = Hour.new
    @d = Time.now
    flash[:notice] = "profile updated"
    erb :"profile/show"
  end


  get '/logout' do
    session.clear
    session[:id] = nil
    flash[:notice] = "Thank you"
    redirect '/'
  end

  delete '/bcs/profile/:id' do 
    @employee = Employee.find_by(:id => params[:id])  
    @employee.destroy
    flash[:notice] = "profile deleted"
    redirect "/"
  end
  #Model uses Employee has_many :hours, :dependent => :destroy, and 
  #Employee has_many :weeks, :dependent => :destroy. 
  
#------------------------Delete----------------------->  
  delete '/bcs/hr/profile/:id' do  #delete route from HR
    @employee = Employee.find_by(:id => params[:id])  
    @employee.destroy
    flash[:notice] = "All records for: <%=@session[first_name]%> <%=@session[last_name]%> have been deleted."
    
    "/hr_profile/show.erb"
  end
end