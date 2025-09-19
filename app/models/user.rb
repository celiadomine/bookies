class User < ApplicationRecord
    has_secure_password
    enum :role, { user: "user", admin: "admin" }, default: "user"

    validates :username, presence: true, uniqueness: true
    validates :email_address, presence: true, uniqueness: true
    validates :password, length: { minimum: 12 }, allow_nil: true
end