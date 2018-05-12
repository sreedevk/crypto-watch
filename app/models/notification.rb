class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> (user_id) { where(user_id: user_id, read: false) }
end
