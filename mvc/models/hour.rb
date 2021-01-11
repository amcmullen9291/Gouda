require 'active_record'
require 'date'

require_relative '../../config/environment'
require_relative 'employee.rb'
require_relative 'week.rb'

class Hour < ActiveRecord::Base
    belongs_to :employee
    validates_presence_of :badge_id
    validates_presence_of :employee_id   
    
    def date_of_next(day)  #inherited from Employee Class?
        date  = Date.parse(day)
        delta = date > Date.today ? 0 : 7
        date + delta
    end

    def revert  
        # @newhours[:counter] = "1"
        hour.counter = hour.class.columns_hash['counter'].default
    end
    
end
