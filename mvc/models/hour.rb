require 'active_record'
require 'date'

require_relative '../../config/environment'
require_relative 'employee.rb'
require_relative 'week.rb'

class Hour < ActiveRecord::Base
    belongs_to :employee
    validates_presence_of :badge_id
    validates_presence_of :employee_id    
    def timecard (counter, shift, logged_time)
        if counter == "1"
            if shift == "1"
                @newhours[:monday_in] = logged_time
            elsif shift == "2"
                @newhours[:tuesday_in] = logged_time
            elsif shift == "3"
                @newhours[:wednesday_in] = logged_time
            elsif shift == "4"
                @newhours[:thursday_in] = logged_time
            elsif shift == "5"
                @newhours[:friday_in] = logged_time
            elsif shift == "6"
                @newhours[:monday_in] = logged_time
            elsif shift == "7"
                @newhours[:monday_in] = logged_time
            end
        end
        if counter == "2" # add a flash[notice] = "hours for today already recorded"
            if shift == "1"
                if @newhours[:monday_out] != 0
                    @newhours[:monday_out] = logged_time
                end 
            elsif shift == "2"
                if @newhours[:tuesday_out] != 0
                    @newhours[:tuesday_out] = logged_time
                end
            elsif shift == "3"
                if @newhours[:wednesday_out] != 0
                    @newhours[:wednesday_out] = logged_time
                end
            elsif shift == "4"
                if @newhours[:thursday_out] != 0
                    @newhours[:thursday_out] = logged_time
                end
            elsif shift == "5"
                if @newhours[:friday_out] != 0
                    @newhours[:friday_out] = logged_time
                end
            elsif shift == "6"
                if @newhours[:saturday_out] != 0
                    @newhours[:saturday_out] = logged_time
                end
            elsif shift == "7"
                if @newhours[:sunday_out] != 0
                    @newhours[:sunday_out] = logged_time
                end
            end
        end
    end

    def date_of_next(day)  #inherited from Employee Class?
        date  = Date.parse(day)
        delta = date > Date.today ? 0 : 7
        date + delta
    end

    def revert  
        @newhours[:counter] = "1"
    end
    
end
