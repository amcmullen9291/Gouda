require './config/environment'

use Rack::MethodOverride
use HoursController
use WeeksController
use HumanResourcesController
use EmployeesController
run ApplicationController.new
