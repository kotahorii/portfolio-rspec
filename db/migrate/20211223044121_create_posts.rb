class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :prefecture
      t.string :city
      t.string :town
      t.string :image
      t.float :lat
      t.float :lng
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
