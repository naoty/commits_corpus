class Crawler
  def initialize
    @client = Octokit::Client.new(access_token: access_token)
    @client.per_page = 100
  end

  def search_popular_repositories(page: 1)
    resource = @client.search_repositories("stars:>=10000", page: page)
    resource.nil? ? [] : resource.items
  end

  private

  def access_token
    Rails.root.join(".secret").read
  end
end
