class Employee < ActiveRecord::Base
    has_secure_password 
    has_many :hours
    has_many :weeks
end