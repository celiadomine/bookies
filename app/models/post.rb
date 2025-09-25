class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :likes, as: :likeable, dependent: :destroy
  
  validates :body, presence: true
end
