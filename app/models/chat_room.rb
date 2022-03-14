class ChatRoom < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  has_many :messages, dependent: :destroy
  validate :self_chating
  validates_uniqueness_of :flat_id, scope: :user_id

  def self_chating
    errors.add(:user, "User can't chat with themselves") if user.id == flat.user.id
  end

end
