class User < ApplicationRecord
  has_many :leaves, dependent: :destroy
  validates_presence_of :name, :email
  validates :remaining_leaves, :numericality => { :less_than_or_equal_to => 14 }


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
