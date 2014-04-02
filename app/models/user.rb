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
  					           confirmation: true, :on => :create

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

  def generate_token(column)  
    begin  
      self[column] = SecureRandom.urlsafe_base64  
    end while User.exists?(column => self[column])  
  end

  def send_password_reset  
    generate_token(:password_reset_token)  
    self.password_reset_sent_at = Time.zone.now  
    save!  
    UserMailer.password_reset(self).deliver  
  end    
end