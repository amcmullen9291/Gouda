require_relative '../../config/environment'
require_relative '../models/hour.rb'
class HoursController < EmployeesController

    post '/bcs/new_employees/hours' do #creates hour instance after signup
        puts params
        @session = session
        @day= "Sunday"
        @date = Hour.new 
        @week =  @date.date_of_next(@day) 

        @newhours = Hour.new(params[:hour])
        @newhours.save
        erb :home
    end

    post '/bcs/hours' do #do the same as about post with form
        @hour = Hour.new
        @hour[:employee_id] = params[:id]
        @hour[:badge_id] = @session[:badge_id]
        @hour.save
        redirect "/bcs/profile/:badge_id/hours"
    end

    get '/bcs/profile/:badge_id/hours' do
        @session = session 
        @newhours = Hour.find_by_badge_id(badge_id = @session[:badge_id])
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

    post '/bcs/profile/:badge_id/new_hours' do 
        @session = session
        puts params
        Hour.connection #unneeded now that config is aware...
        daily = Date.new
        @counter = params[:counter]
        @shift =  daily.cwday  
        @logged_time = params[:time] 

        @newhours = Hour.find_by_badge_id(badge_id = @session[:badge_id])
        @newhours.timecard(@counter, @shift, @logged_time)
        @counter = @counter.to_i
        @counter +=1
        @counter = @counter.to_s
        if @counter == "3" then 
            @counter.revert
        end
        @newhours[:counter] = @counter
        @newhours.save  

        @day= "Sunday" #only here so profile re-populates date
        @date = Hour.new 
        @week =  @date.date_of_next(@day)

        @d = Time.now #for params[:time]
        flash[:notice] =  "Time Card has been Updated." 
        erb :"/profile/show"
    end


    delete '/bcs/profile/:id/reset' do # A new Week Class instance progression
        @hours = Hour.find(:id => @session[:hour_id]) #or params[:id]
        @hours.destroy
        
        erb :passage
    end
end 