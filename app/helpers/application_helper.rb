module ApplicationHelper
  include Auth
  def resource_exists(type)
    paths = Dir.glob("app/assets/#{type}/#{controller_name}/*")
    return paths.present?
  end

  def get_user
    @user = get_authenticated_user
    # return @user.email
  end
end
