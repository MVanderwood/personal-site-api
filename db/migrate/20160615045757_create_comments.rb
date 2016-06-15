class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :blog_id
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
