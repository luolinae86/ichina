class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers, id: false do |t|
      t.string :id, limit: 36, primary_key: true, null: false
      t.string :nick_name, limit: 50
      t.string :phone, limit: 20
      t.string :address, limit: 50
      t.timestamps
    end
  end
end
