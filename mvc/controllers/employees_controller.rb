require 'sinatra/base'
require 'sinatra/flash'
require 'rack-flash'
require_relative '../../config/environment'

class EmployeesController < ApplicationController
  
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
      flash[:notice] = "Of all the gin joints in all the towns in all the world, she walks into mine. -Rick Blaine"
      @notice = flash[:notice]
      redirect '/bcs/login'
    end
  end

  post '/bcs/new_employee' do
    @employee = Employee.create(params[:employee])
    # @employee.save

    @session = session
    @session[:id] = @employee.id
    @session[:badge_id] = @employee.badge_id
    # @session[:dept_id] = @employee.dept_id
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
      @session[:id] = @employee[:id]
      @session[:badge_id] = params[:employee][:badge_id]

      @employee.hours << @newhours = Hour.find_by(:employee_id => @session[:id])
      @session[:hours_id] = @newhours[:id]
      @session[:monday_in] = @newhours[:monday_in]
      @session[:monday_out] = @newhours[:monday_out]
      @session[:tuesday_in] = @newhours[:tuesday_in]
      @session[:tuesday_out] = @newhours[:tuesday_out]
      @session[:wednesday_in] = @newhours[:wednesday_in]
      @session[:wednesday_out] = @newhours[:wednesday_out]
      @session[:thursday_in] = @newhours[:thursday_in]
      @session[:thursday_out] = @newhours[:thursday_out]
      @session[:friday_in] = @newhours[:friday_in]
      @session[:friday_out] =  @newhours[:friday_out]
      @session[:saturday_in] = @newhours[:saturday_in]
      @session[:saturday_out] = @newhours[:saturday_out]
      @session[:sunday_in] = @newhours[:sunday_in]
      @session[:sunday_out] = @newhours[:sunday_out]

      @day= "Sunday"
      @date = Hour.new 
      @week =  @date.date_of_next(@day)    
      @d = Time.now
      
      erb :"profile/show"
    else
      flash[:notice] = "Of all the gin joints in all the towns in all the world, she walks into mine. -Rick Blaine"
      @notice = flash[:notice]
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

    @date = Hour.new
    @day= "Sunday"
    @week =  @date.date_of_next(@day)

    @newhours = Hour.new
    @d = Time.now
    flash[:notice] = "profile updated"
    erb :"profile/show"
  end

  get '/bcs/profile/:badge_id/newhours' do 
    @session = session
    @employee = Employee.find_by(:badge_id => @session[:badge_id])
    @newhours = @employee.hours

      @day= "Sunday"
      @date = Hour.new 
      @week =  @date.date_of_next(@day)    
      @d = Time.now

      erb :"profile/show"
    end

  get '/logout' do
    session.clear
    session[:id] = nil
    flash[:notice] = "Thank you"
    redirect '/'
  end

  delete '/bcs/profile/:id' do 
    @session = session
    flash[:notice] = "profile deleted"

    Employee.delete(@session[:id])

    redirect "/"
  end
  #Model uses Employee has_many :hours, :dependent => :destroy, and 
  #Employee has_many :weeks, :dependent => :destroy. 
  
#------------------------Delete----------------------->  
  delete '/bcs/hr/profile/:id' do  #delete route from HR
    @session = session
    flash[:notice] = "All records for : @session[:first_name] @session[:last_name] have been removed."

    Employee.delete(@session[:id])

    erb :"/hr_profile/show"
  end
end