class Commit < ActiveRecord::Base
  belongs_to :repository

  before_save   :create_index
  after_destroy :delete_index

  INDEX = Rails.env.test? ? "test_commits" : "commits"

  def self.search(keyword)
    client = Elasticsearch::Client.new
    results = client.search(index: INDEX, type: "commit", q: keyword)
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
