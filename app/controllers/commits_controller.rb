class CommitsController < ApplicationController
  def search
  end

  def index
    body = {}
    body[:query] = {}
    body[:query][:match] = {}
    body[:query][:match][:message] = params[:keyword]
    results = client.search(index: "commits", body: body)
    @commits = results["hits"]["hits"].map { |result| result["_source"] }
  end

  private

  def client
    Elasticsearch::Client.new
  end
end
