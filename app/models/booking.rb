class Booking < ApplicationRecord
  belongs_to :diagnostician, class_name: "User", foreign_key: "user_id"
  belongs_to :housing, optional: true
  belongs_to :diagnostic
  validates :set_at, presence: :true
  validates :user_id, presence: :true

  scope :for_me, -> (user) { where(diagnostician: user) }
  scope :to_come, -> { where("set_at > ?", DateTime.now) }
  scope :ending_soon, -> { order(set_at: :asc) }


  def booker
    self.housing.users.first
  end

  def self.incoming user
    for_me(user)
      .to_come
      .ending_soon
  end

end
