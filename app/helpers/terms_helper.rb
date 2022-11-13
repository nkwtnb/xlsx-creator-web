module TermsHelper
  def get_terms
    file = File.open(Rails.root.join("TERMS.md"))
    parsed = CommonMarker.render_html(file.read, :DEFAULT)
    raw(parsed)
  end
end
