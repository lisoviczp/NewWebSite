class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.boolean :approved
      t.string :vibe_type
      t.text :body
      t.string :url

      t.timestamps null: false
    end
  end
end
