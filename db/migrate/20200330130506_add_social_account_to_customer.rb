class AddSocialAccountToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :social_account, :string, comment: :用户发贴用的社交帐号
  end
end
