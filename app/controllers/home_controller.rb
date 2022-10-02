class HomeController < ApplicationController
  include Auth
  def new
    token = get_authenticated_user()
    if token.nil?
      return redirect_to sign_in_path
    end
  end
end
