class CommitsController < ApplicationController
  def search
  end

  def index
    @commits, @total = Commit.search(params[:keyword])
  end

  private

  def client
    Elasticsearch::Client.new
  end
end
