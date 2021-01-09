class WeeksController < EmployeesController

    post "/bcs/profile/:badge_id/post_hours" do 
        #before you do shotgun, Post/create weeks instance,
        #do @weeks = Weeks.select |week| :employee_id => @session[:id]...
        #and define @current_week = @weeks.first {for @weeks[:week_ending]}
        #AND READ YOUR NOTEBOOK NOTES!
        @day= "Sunday" #not used- hidden @session data used to fill space; <tr> data
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
        # @weeks = Employee.left_outer_joins(:weeks) 
        #join method for employee and week/
        #may get asked about Employee.weeks
        #join is for total # of week and start date
        #may need a show.erb to detail weeks instances. (no, you won't)                                 #may need another show.erb to detail weeks instances.
        @weeks = []
        flash[:notice] = "Time Card Submitted. Thank You." #flash wont pass through 2nd route
        erb :"profile/weeks/index"
    end
end  