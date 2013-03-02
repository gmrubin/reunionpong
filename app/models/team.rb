class Team < ActiveRecord::Base
  attr_accessible :city, :name, :user_ids
  has_many :users

  validates :name, presence: true
  validates :city, presence: true

  before_validation :validate_pair

  def validate_pair
    errors.add(:team, "too many users") if self.users.count >= 2
  end

  def add_user!(user)
    self.users.push(user) unless user.on_team?
    errors.add(:team, "already on a team")
    self
  end

  def remove_user!(user)
    self.users.delete(user)
  end

end
