class APIController < ActionController::API
  include ActionController::Cookies
end

class ApplicationController < ActionController::Base
  layout "application"
  include ActionController::Cookies
end
