require_relative '../../config/environment'
require_relative '../models/week.rb'

class WeeksController < EmployeesController

    post "/bcs/post_week/:badge_id" do         
        @day= "Sunday" #not used; @session data in hidden input fields used to fill space in <tr> 
        @date = Hour.new 
        @week =  @date.date_of_next(@day)

        @session = session  
        @timecard = Week.new(params[:week])
        @timecard[:employee_id] = @session[:id]
        @timecard[:badge_id] = @session[:badge_id]
        @timecard[:dept_id] = @session[:dept_id]
        @timecard[:monday_in] = @session[:monday_in]
        @timecard[:monday_out] = @session[:monday_out]
        @timecard[:tuesday_in] = @session[:tuesday_in]
        @timecard[:tuesday_out] = @session[:tuesday_out]
        @timecard[:wednesday_in] = @session[:wednesday_in]
        @timecard[:wednesday_out] = @session[:wednesday_out]
        @timecard[:thursday_in] = @session[:thursday_in]
        @timecard[:thursday_out] = @session[:thursday_out]
        @timecard[:friday_in] = @session[:friday_in]
        @timecard[:friday_out] = @session[:friday_out]
        @timecard[:saturday_in] = @session[:saturday_in]
        @timecard[:saturday_out] = @session[:saturday_out]
        @timecard[:sunday_in] = @session[:sunday_in]
        @timecard[:sunday_out] = @session[:sunday_out]
        @session[:week_ending] = params[:week][:week_ending]
        @session[:week_id] = @timecard[:id]
        @timecard.save  #current "week's Hour values already stored in @sessions

        @weeks = Week.select {|week, v| week[:badge_id] == @session[:employee_id]}

        flash[:notice] = "Time Card Submitted. Thank You." 
        erb :"profile/weeks/index", :layout => false
    end
end  