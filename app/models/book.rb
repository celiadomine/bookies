class Book < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy
    has_many :posts, dependent: :destroy
  
    enum :label, { reading: 0, read: 1, dnf: 2, favorites: 3, bought: 4, wishlist: 5 }
  
    validates :title, presence: true
    validates :google_books_id, presence: true, uniqueness: true
  
  end