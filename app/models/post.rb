class Post < ApplicationRecord
  acts_as_votable

  validates :user_id, presence: true
  validates :image, presence: true
  validates :caption, length: { maximum: 300 }

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  scope :of_followed_users, -> (following_users) { where user_id: following_users }
end
