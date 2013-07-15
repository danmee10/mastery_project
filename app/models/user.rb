class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation

  has_many :poems

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :password, presence: true
  validates_length_of :password, :minimum => 8, :message => "password must be at least 8 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
end
