class AddColumnTelTypeToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :tel_type, :integer, default: 0, comment: '社交账号类型'
    add_column :customers, :user_name, :string, limit: 50, comment: '用户名'
    add_column :customers, :postcodes, :string, limit: 20, comment: '邮编'
    add_column :customers, :user_pwd, :string, limit: 50, comment: '用户状态'
  end
end
