class Comment < ActiveRecord::Base
  validates :user_id, presence: true
  validates :gram_id, presence: true
  validates :message, presence: true

  belongs_to :user
  belongs_to :gram
end
  