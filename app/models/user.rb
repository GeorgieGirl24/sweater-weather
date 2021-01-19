class User < ApplicationRecord
  before_create :set_api_key

  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :password, confirmation: true
  validates :api_key, uniqueness: true

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
