require "crawler"

namespace :crawler do
  desc "Crawl repositories in order of the number of stars"
  task :repositories => :environment do
    crawler = Crawler.new

    page = 1
    while results = crawler.search_popular_repositories(page: page)
      break if results.empty?
      results.each do |result|
        next if Repository.exists?(uid: result.id)
        attrs = {}
        attrs[:uid] = result.id
        attrs[:name] = result.name
        attrs[:full_name] = result.full_name
        attrs[:language] = result.language
        Repository.create(attrs)
      end
      page += 1
    end
  end

  desc "Crawl commits of crawled repositories"
  task :commits => :environment do
    crawler = Crawler.new
    repositories = Repository.all
    repositories.each do |repository|
      sha = nil
      while commits = crawler.crawl_commits(repository.full_name, sha)
        break if commits.empty?
        commits.each do |commit|
          message = commit[:commit][:message]
          next unless message.include?("\n\n")

          attrs = {}
          attrs[:sha] = commit[:sha]
          attrs[:message] = message
          attrs[:repository_id] = repository.id
          Commit.create(attrs) rescue next
        end
        last_commit_sha = commits.last.sha
        break if sha == last_commit_sha
        sha = last_commit_sha
      end
    end
  end
end
