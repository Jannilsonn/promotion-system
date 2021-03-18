class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.belongs_to :promotion

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end
end
