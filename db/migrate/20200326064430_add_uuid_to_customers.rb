class AddUuidToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :uuid, :string, limit: 36
    add_column :customers, :head_url, :string
  end
end
