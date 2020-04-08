class AddUserStateToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :user_state, :integer, default: 0, comment: '用户状态'
  end
end
