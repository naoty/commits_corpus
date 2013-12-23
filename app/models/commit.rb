class Commit < ActiveRecord::Base
  belongs_to :repository

  before_save   :create_index
  after_destroy :delete_index

  private

  def client
    @client ||= Elasticsearch::Client.new
  end

  def create_index
    query = {}
    query[:index] = Rails.env.test? ? "test_commits" : "commits"
    query[:type]  = "commit"
    query[:body]  = self.to_json(only: [:sha, :message])
    result = client.index(query)
    self.index_id = result["_id"]
  end

  def delete_index
    query = {}
    query[:index] = Rails.env.test? ? "test_commits" : "commits"
    query[:type]  = "commit"
    query[:id]    = index_id
    client.delete(query)
  end
end
