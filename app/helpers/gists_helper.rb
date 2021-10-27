module GistsHelper
  def gist_html_url(gist)
    "https://gist.github.com/#{gist.gist_id}"
  end
end
