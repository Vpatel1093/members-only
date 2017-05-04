class User < ApplicationRecord
  attr_accessor :remember_token

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true
  before_save :downcase_email
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    User.digest(token) == send("#{attribute}_digest")
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

      # Converts email to all lower-case.
      def downcase_email
        self.email = email.downcase
      end
end
