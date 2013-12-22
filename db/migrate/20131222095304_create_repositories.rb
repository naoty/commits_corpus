class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.integer :uid
      t.string :name
      t.string :full_name
      t.string :language

      t.timestamps
    end
  end
end
