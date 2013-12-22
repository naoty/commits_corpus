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
end
