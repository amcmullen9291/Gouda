require_relative '../../config/environment'
require_relative '../models/hour.rb'

class HoursController < EmployeesController

    post '/bcs/new_employees/hours' do #creates hour instance after signup
        @session = session
        @day= "Sunday"
        @date = Hour.new 
        @week =  @date.date_of_next(@day) 

        @newhours = Hour.new(params[:hour])
        @newhours.save
        erb :home
    end

    post '/bcs/hours' do #do the same as above post with form (from :passage)
        @session = session

        @day= "Sunday"
        @date = Hour.new 
        @week =  @date.date_of_next(@day)

        @hour = Hour.new
        @hour[:employee_id] = params[:id]
        @hour[:badge_id] = @session[:badge_id]
        @hour[:week_ending] = @week
        @hour.save
        redirect "/bcs/profile/:badge_id/hours"
    end

    get '/bcs/profile/:badge_id/hours' do
        puts params
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
puts @newhours[:counter]
        erb :"profile/show"
    end

    get '/bcs/profile/:badge_id/hours/edit' do
        @session = session
        puts @session[:conunter]
        @newhours = Hour.find_by(:id => @session[:hours_id])
        @date = Hour.new #for date
        @day= "Sunday"
        @week =  @date.date_of_next(@day)
        @d = Time.new

        @counter = @newhours[:counter]
        puts "----------check --------------->"
        puts @counter
        erb :"/profile/hours_edit"
    end

    patch '/new_hours/:hours_id' do 
        @session = session
        # Hour.connection #unneeded now that config is aware...
        @newhours = Hour.find_by_id(params[:id])
        @newhours.update(params[:hours])
        counter = @newhours[:counter]
            counter = counter.to_i
            counter +=1
            if counter == 3
                @newhours[:counter] = "1"
            else
                @newhours[:counter] = counter
            end
        @newhours.save
        puts counter
        puts @newhours[:counter] #rmove this
        @session[:badge_id]= @newhours[:badge_id]
    
        flash[:notice] =  "Time Card has been Updated." 
        redirect '/bcs/profile/:badge_id/hours' 
    end

    delete '/bcs/profile/:id/reset' do # A new Week Class instance progression
       @session = session
        Hour.delete(@session[:hours_id])
        erb :passage
    end
end 