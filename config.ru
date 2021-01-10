require_relative './config/environment'

use Rack::MethodOverride
use HoursController
use WeeksController
use HumanResourcesController
run EmployeesController.new