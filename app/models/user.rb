class User < ActiveRecord::Base
  has_many :posts

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = @password
  end

  def authenticate(password)
    self.password == password
  end
end