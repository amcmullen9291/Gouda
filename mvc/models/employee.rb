require 'active_record'

require 'date'
require_relative '../../config/environment'
require_relative 'hour.rb'
require_relative 'week.rb'


class Employee < ActiveRecord::Base
    has_secure_password 
    has_many :hours, :dependent => :destroy
    has_many :weeks, :dependent => :destroy
    validates_presence_of :badge_id
    validates_presence_of :password

    def date_of_next(day)
        date  = Date.parse(day)
        delta = date > Date.today ? 0 : 7
        date + delta
    end

    def each_after(n) 
        each_with_index do |elem, i|
          yield elem if i >= n
      end
    end

end