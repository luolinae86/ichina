class CreateLoginRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :login_records do |t|
      t.string :user_name, limit: 20, null: false, comment: '帐号'
      t.string :token, limit: 50, null: false, comment: 'token'
      t.string :user_id, limit: 32, default: nil
      t.integer :user_type, default: 0, comment: '0'
      t.integer :user_state, default: 0, comment: '0,1'
      t.string :create_pin, limit: 50, null: false, comment: '创建人'
      t.string :update_pin, limit: 50, null: false, comment: '更新人'
      t.integer :sys_version, null: false, default: 1, comment: '版本号'
      t.boolean :yn, default: false, comment: '删除标识 0:有效 1:无效'
      t.timestamps
    end
  end
end
