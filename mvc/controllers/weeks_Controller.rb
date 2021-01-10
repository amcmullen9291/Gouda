class WeeksController < EmployeesController

    post "/bcs/profile/:badge_id/post_hours" do         
        @day= "Sunday" #not used; @session data in hidden input fields used to fill space in <tr> 
        @date = Hour.new 
        @week =  @date.date_of_next(@day)

        @session = session  
        @timecard = Week.new
        @timecard[:employee_id] = @session[:id]
        @timecard[:badge_id] = @session[:badge_id]
        @timecard[:dept_id] = @session[:dept_id]
        @timecard[:monday_in] = @session[:monday_in]
        @timecard[:monday_out] = @session[:monday_in]
        @timecard[:tuesday_in] = @session[:monday_in]
        @timecard[:tuesday_out] = @session[:monday_in]
        @timecard[:wednesday_in] = @session[:monday_in]
        @timecard[:wednesday_out] = @session[:monday_in]
        @timecard[:thursday_in] = @session[:monday_in]
        @timecard[:thursday_out] = @session[:monday_in]
        @timecard[:friday_in] = @session[:monday_in]
        @timecard[:friday_out] = @session[:monday_in]
        @timecard[:saturday_in] = @session[:monday_in]
        @timecard[:saturday_out] = @session[:monday_in]
        @timecard[:sunday_in] = @session[:monday_in]
        @timecard[:sunday_out] = @session[:monday_in]
        @session[:week_id] = @timecard[:id]
        @timecard.save  #current week's/ Hours values already stored in @sessions

    ####### start here######  
        @weeks = Weeks.select {|week| week[:employee_id] => @session[:id]}
        @first_week = @weeks.first
        flash[:notice] = "Time Card Submitted. Thank You." 
        erb :"profile/weeks/index", :layout => false
    end
end  