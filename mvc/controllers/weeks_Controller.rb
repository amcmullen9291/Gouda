class WeeksController < EmployeesController

    post "/bcs/profile/:badge_id/post_hours" do 

        erb :"profile/weeks/index"
    end
end 