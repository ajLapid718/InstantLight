class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subscribed_user
  belongs_to :post
end
