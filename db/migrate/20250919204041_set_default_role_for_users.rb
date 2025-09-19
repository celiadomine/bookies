class SetDefaultRoleForUsers < ActiveRecord::Migration[8.0]
  def change
    User.where(role: nil).update_all(role: "user")
  end
end