class CommitsController < ApplicationController
  def search
  end

  def index
    @commits, @related_words, @total = Commit.search(params[:keyword], params[:page] || 1)
    @last_page = @total / Commit::PER_PAGE + 1
  end

  private

  def client
    Elasticsearch::Client.new
  end
end
