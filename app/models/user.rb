require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  REGEX_USERNAME = /\A\w+\z/
  REGEX_COLOR = /\A#[\h]{3,6}\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy

  before_save :text_downcase
  before_save :encrypt_password

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: /@/ }

  validates :username, length: { maximum: 40 }
  validates :username, format: { with: REGEX_USERNAME }

  validates :password, presence: true, on: :create, confirmation: true

  validates :color, format: { with: REGEX_COLOR }

  private

  # Служебный метод, преобразующий бинарную строку в 16-ричный формат,
  # для удобства хранения.
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email.downcase)
    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password
    nil
  end

  def text_downcase
    self.username = username&.downcase if !!username
    self.email = email&.downcase if !!email
  end

  # Шифруем пароль, если он задан
  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end
end
