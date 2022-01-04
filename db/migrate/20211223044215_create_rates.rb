class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.float :rate, default: 0

      t.timestamps
    end
  end
end
