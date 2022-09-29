module ApplicationHelper
  def resource_exists(type)
    paths = Dir.glob("app/assets/#{type}/#{controller_name}/*")
    return paths.present?
  end
end
