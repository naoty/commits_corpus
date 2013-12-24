class Crawler
  def initialize
    @client = Octokit::Client.new(access_token: access_token)
    @client.per_page = 100
  end

  def search_popular_repositories(page: 1)
    resource = @client.search_repositories("stars:>=10000", page: page)
    resource.nil? ? [] : resource.items
  end

  def crawl_commits(repository_name, sha)
    puts "Crawling commits until: #{sha}"
    commits = @client.commits(repository_name, sha)
  end

  private

  def access_token
    Rails.root.join(".secret").read
  end
end
