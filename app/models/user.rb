class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  before_validation :whitelisted?

  private
    def whitelisted?
      unless Whitelist.exists?(:email=>email)
        errors.add :email, " is not on our list. If you think this is an error please email info@reunionpong.com"
      end
    end
end
