class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings
  has_many :user_housings
  has_many :housings, through: :user_housings

 enum role: [ :particulier, :diagnostician ]


# # conversation.update! status: 0
# conversation.active!
# conversation.active? # => true
# conversation.status # => "active"

# # conversation.update! status:1
# conversation.archived!
# conversation.archived? # => true
# conversation.status # => "archived"

# # conversation.update! status: 1

# conversation.status = "archived"

# # conversation.update! status: nil
# conversation.status = nil
# conversation.status.nil? # => true
# conversation.status # => nil



end
