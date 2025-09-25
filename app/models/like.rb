class Like < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller&.current_user }

  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
