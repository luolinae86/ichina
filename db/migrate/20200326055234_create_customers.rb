class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :nick_name, limit: 50
      t.string :phone, limit: 20
      t.string :address, limit: 50
      t.timestamps
    end
  end
end
