class Follow < ApplicationRecord
  belongs_to :follower,
    primary_key: :id,
    foreign_key: :follower_id,
    class_name: 'User'

  belongs_to :following,
    primary_key: :id,
    foreign_key: :following_id,
    class_name: 'User'
end
