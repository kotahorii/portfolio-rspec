class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduction, :string, limit: 140
    add_column :users, :prefecture, :integer, default: 1

    remove_column :users, :nickname, :string
  end
end
