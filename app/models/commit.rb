class Commit < ActiveRecord::Base
  belongs_to :repository

  before_save   :create_index
  after_destroy :delete_index

  INDEX = Rails.env.test? ? "test_commits" : "commits"
  PER_PAGE = 10

  def self.search(keyword, page = 1)
    client = Elasticsearch::Client.new
    offset = (page.to_i - 1) * PER_PAGE
    results = client.search(index: INDEX, type: "commit", q: keyword, from: offset)
    total = results["hits"]["total"]
    commits = results["hits"]["hits"].map { |hit| Commit.new(hit["_source"]) }
    [commits, total]
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
