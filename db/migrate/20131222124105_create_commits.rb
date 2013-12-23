class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :sha
      t.string :message
      t.string :index_id
      t.references :repository, index: true

      t.timestamps
    end
  end
end
