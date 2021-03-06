require 'sinatra/flash'
require 'rack-flash'

require_relative '../../config/environment'
require_relative '../../mvc/models/employee.rb'

class HumanResourcesController < EmployeesController
  get '/bcs/hr_portal'  do 
    @session = session
    if @session[:office] == "YES"
      erb :"hr_profile/show"
    else
      flash[:notice] = "You are not authorized to view this information"
      erb :verification, :layout => false
    end
  end
    
  post '/bcs/hr_portal/search/search' do 
    @session = session
    if @session[:office] == "YES" 
      if params[:criteria] == "last_name"    
        @employees = Employee.select {|employee, v| employee[:last_name].downcase == params[:query].downcase}
        if @employees.count >= 1 
          erb :"/hr_profile/search_results/show"
        else 
          flash[:notice] = "no record found"
          erb :"hr_profile/show", :layout => false
        end
      elsif params[:criteria] == "badge_id"
        @employees = Employee.select {|employee, v| employee[:badge_id] == params[:query]}
        if @employees.count >= 1
          erb :"/hr_profile/search_results/show"
        else
          flash[:notice] = "no record found"
          erb :"hr_profile/show", :layout => false
        end
      end
    else
      flash[:notice] = "You are not authorized to view this information"
      erb :"home", :layout => false
    end
  end

  post '/bcs/hr/profile/:badge_id' do
    @session = session
    @employee = Employee.find(params[:id])
      @session[:badge_id] = @employee[:badge_id]
      @session[:last_name] = @employee[:last_name]
      @session[:id] = @employee[:id]
      @session[:shift_id] = @employee[:shift_id]
      @session[:first_name] = @employee[:first_name]
      @session[:dept_id] = @employee[:dept_id]
      @session[:email] = @employee[:email]
      @session[:telephone] = @employee[:telephone]
      @session[:password] = @employee[:password]
      @session[:location] = @employee[:location]
      @session[:dept_id] = @employee[:dept_id]

    erb :"/hr_profile/search_results/edit"
  end

  patch "/bcs/hr/profile/:badge_id/modify" do
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
    @session[:info] = @employee[:info]
    @session[:office] = "YES"

    @date = Hour.new
    @day= "Sunday"
    @week =  @date.date_of_next(@day)

    flash[:notice] = "profile has been updated"
    @confirm = flash[:notice]
    redirect '/bcs/hr_portal'
  end 

# ------------------------record deleted from Employee Controller----------------->
      # delete '/bcs/hr/profile/:id' do
      #   @employee = Employee.find_by(:id => params[:id])  
      #   @employee.destroy
      #   flash[:notice] = "record deleted"
      #     redirect "/hr_profile/show.erb"
      #   end (separation of concerns)
end