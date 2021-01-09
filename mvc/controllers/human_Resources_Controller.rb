class HumanResourcesController < EmployeesController

    get '/bcs/hr_portal'  do 
        @session = session
        if @session[:office] == "YES"
          erb :"hr_profile/show"
        else
          flash[:notice] = "You are not authorized to view this information"
        end
    end
          
end 