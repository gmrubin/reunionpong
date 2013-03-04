class User < ActiveRecord::Base
  belongs_to :team
  rolify
  scope :solo, where('team_id IS NULL')
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :handle, :accept

  before_validation :whitelisted?, on: :create

  before_validation :accept, acceptance: true, on: :create

  validates :name, presence: true

  def on_team?
    !self.team.blank?
  end

  def to_s
    name
  end

  def partner
    users = self.team.users
    users = users.delete_if {|u| u == self }
    users.first
  end

  private
    def whitelisted?
      unless Whitelist.exists?(:email=>email)
        errors.add :email, " is not on our list #{email}. If you think this is an error please email reunionpong@gmail.com"
      end
    end
end
