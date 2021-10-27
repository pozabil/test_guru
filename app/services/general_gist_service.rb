class GeneralGistService
  def initialize(gist_id)
    @gist_id = gist_id
    @client = Octokit::Client.new(access_token: ENV['GITHUB_GIST_TOKEN'])
  end

  def delete
    @client.delete_gist(@gist_id)
  end

  def synchronize
    @client.gist(@gist_id)
    true
  rescue Octokit::NotFound
    false
  end
end
