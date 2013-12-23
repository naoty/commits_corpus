require "spec_helper"

describe Commit do
  context "After a commit is saved" do
    let(:client) { Elasticsearch::Client.new }
    let(:commit) { FactoryGirl.build(:commit) }

    after { client.indices.delete(index: "test_commits") }

    it "should send index API" do
      commit.save
      expect(commit.index_id).to be_true
    end
  end
end
