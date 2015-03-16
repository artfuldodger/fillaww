class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :reddit_permalink
      t.string :source_url
      t.string :title
      t.attachment :file

      t.timestamps null: false
    end
  end
end
