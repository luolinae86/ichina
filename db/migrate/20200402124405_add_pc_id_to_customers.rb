class AddPcIdToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :pc_id, :string, limit: 40, comment: :'PC端的用户ID'
  end
end
