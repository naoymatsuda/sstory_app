class Story < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 50 }
  validates :start_text, presence: true, length: { maximum: 140 }
  validates :consent_text, presence: true, length: { maximum: 140 }
  validates :terning_text, presence: true, length: { maximum: 140 }
  validates :finish_text, presence: true, length: { maximum: 140 }
  
  def like(user)
    likes.create(user_id: user.id)
  end
  
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def like?(user)
    like_users.include?(user)
  end
  
end
