module UsageHelper
  def get_usage
    uri = URI.parse("https://raw.githubusercontent.com/nkwtnb/xlsx-creator-web/main/USAGE.md")
    response = Net::HTTP.get_response(uri)

    puts response.code # status code
    puts response.body # response body
    parsed = CommonMarker.render_html(response.body, :DEFAULT)
    raw(parsed)
  end
end
