module UsageHelper
  def get_usage
    file = File.open(Rails.root.join("USAGE.md"))
    parsed = CommonMarker.render_html(file.read, :DEFAULT)
    raw(parsed)
  end
end
