class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :description
      t.string :contact
      t.string :comission
      t.integer :category_id, presence: true
      t.string :hidden_key, uniqueness: true

      t.timestamps null: false
    end
  end
end
