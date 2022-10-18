module TermsHelper
  def get_terms
    puts "hello Term"
    uri = URI.parse("https://raw.githubusercontent.com/nkwtnb/xlsx-creator-web/main/TERMS.md")
    response = Net::HTTP.get_response(uri)

    puts response.code # status code
    puts response.body.force_encoding("UTF-8") # response body
    parsed = CommonMarker.render_html(response.body, :DEFAULT)
    raw(parsed)
  end
end
