class HoursController < EmployeesController

    post '/bcs/new_employee/hours' do
        @hour = Hour.new
        @hour[:employee_id] = params[:id]
        @hour[:badge_id] = params[:badge_id]
        @hour.save
        redirect '/'
    end

    get '/bcs/profile/:badge_id/hours' do
        @session = session 
        @newhours = Hour.find_by(:badge_id => @session[:badge_id])
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
        @session[:sunday_in] = @newhours[:sunday_in]
        @session[:hours_id] = @newhours[:id]
        @session[:counter] = @newhours[:counter]

        @day= "Sunday"
        @date = Hour.new 
        @week =  @date.date_of_next(@day)    
        @d = Time.now
        erb :"profile/show"
    end
end 