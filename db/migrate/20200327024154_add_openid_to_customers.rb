class AddOpenidToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :openid, :string, limit: 50
  end
end
