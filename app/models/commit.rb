class Commit < ActiveRecord::Base
  belongs_to :repository

  before_save   :create_index
  after_destroy :delete_index

  INDEX = Rails.env.test? ? "test_commits" : "commits"
  PER_PAGE = 10

  def self.search(keyword, page = 1)
    client = Elasticsearch::Client.new
    offset = (page.to_i - 1) * PER_PAGE

    body = {}
    body[:query] = {}
    body[:query][:match] = {}
    body[:query][:match][:message] = keyword
    body[:facets] = {}
    body[:facets][:message] = {}
    body[:facets][:message][:terms] = {}
    body[:facets][:message][:terms][:field] = "message"
    body[:facets][:message][:terms][:exclude] = keyword.split(" ").map(&:downcase)

    result  = client.search(index: INDEX, body: body, from: offset)
    commits = result["hits"]["hits"].map { |hit| Commit.new(hit["_source"]) }
    total   = result["hits"]["total"]
    related_terms = result["facets"]["message"]["terms"]

    [commits, related_terms, total]
  end

  private

  def create_index
    client = Elasticsearch::Client.new
    body = self.to_json(only: [:sha, :message, :repository_id])
    result = client.index(index: INDEX, type: "commit", body: body)
    self.index_id = result["_id"]
  end

  def delete_index
    client = Elasticsearch::Client.new
    client.delete(index: INDEX, type: "commit", id: index_id)
  end
end
