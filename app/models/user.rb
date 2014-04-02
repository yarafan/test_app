class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  
  
  attr_accessor :password
  before_save :encrypt_password

  EMAIL_VALID = /\A(\w+-?\w+)@([a-z]+\.[a-z\.]+)\z/

  validates :login, presence: true,
  					        uniqueness: true,
  					        length: { minimum: 3 }
  validates :email, presence: true,
  					        uniqueness: true,
  					        format: { with: EMAIL_VALID }
  validates :birthday, presence: true
  validates :password, presence: true,
  					           #length: { minimum: 6 },
  					           confirmation: true

  def self.authenticate(login, password)
    user = User.find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end