class User < ApplicationRecord
    has_secure_password
    has_many :books, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy

    enum :role, { user: 0, admin: 1}, default: :user

    validates :username, presence: true, uniqueness: true
    validates :email_address, presence: true, uniqueness: true
    validates :password, length: { minimum: 12 }, allow_nil: true
end