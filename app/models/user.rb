# frozen_string_literal: true

class User < ApplicationRecord
  include OooPeriodCounts
  include UserConcerns

  has_paper_trail

  has_many :ooo_periods, class_name: 'OOOPeriod'
  has_many :leaves
  has_many :wfhs
  validates :name, :email, :oauth_token, :token_expires_at, presence: true
  validate :beautifulcode_mail
  validate :check_leaving_date

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize

    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email
    user.oauth_token = auth.credentials.token
    user.token_expires_at = auth.credentials.expires_at
    user.save!
    user
  end

  def beautifulcode_mail
    return unless email
    return if ['beautifulcode.in', 'beautifulcode.co'].include?(email.split('@')[1])

    errors.add(:email, 'must be a beautifulcode email')
  end

  def check_leaving_date
    return unless leaving_date

    joining_date > leaving_date ? errors.add(:leaving_date, 'can not be before joining date') : nil
  end
end
