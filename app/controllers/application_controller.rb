class ApplicationController < ActionController::Base
    include Authentication
end


#for checking Admin authentication
class AdminController < ActionController::Base
    #all child-controller needs pass below authenticate
    #http_basic_authenticate_with name:'admin', password:'pass'
end