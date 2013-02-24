class Team < ActiveRecord::Base
  attr_accessible :city, :name
  has_many :users

  validates :name, presence: true
  validates :city, presence: true

  before_validation :validate_pair

  def validate_pair
    errors.add(:team, "too many users") if self.users.count >= 2
  end
end
