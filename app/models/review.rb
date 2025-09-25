class Review < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller&.current_user }

  belongs_to :user
  belongs_to :book

  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
end
