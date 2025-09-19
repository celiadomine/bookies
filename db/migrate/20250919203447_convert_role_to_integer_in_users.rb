class ConvertRoleToIntegerInUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :role_temp, :integer

    User.reset_column_information
    User.all.each do |user|
      case user[:role]
      when "user"
        user.update_column(:role_temp, 0)
      when "admin"
        user.update_column(:role_temp, 1)
      end
    end

    remove_column :users, :role
    rename_column :users, :role_temp, :role
  end

  def down
    add_column :users, :role_temp, :string

    User.reset_column_information
    User.all.each do |user|
      case user[:role]
      when 0
        user.update_column(:role_temp, "user")
      when 1
        user.update_column(:role_temp, "admin")
      end
    end

    remove_column :users, :role
    rename_column :users, :role_temp, :role
  end
end