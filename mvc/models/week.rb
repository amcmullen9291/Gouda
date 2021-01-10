require 'active_record'
require 'date'
require_relative '../../config/environment'
require_relative 'employee.rb'
require_relative 'hour.rb'

class Week < ActiveRecord::Base
    belongs_to :employee
    validates_presence_of :badge_id
    validates_presence_of :employee_id    
    
#method not used yet...
    def each_after(n) 
        each_with_index do |elem, i|
          yield elem if i >= n
      end
    end
      
end