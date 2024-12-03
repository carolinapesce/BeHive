class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.surname = auth.info.surname
      user.cf = auth.info.cf
      user.phone_number = auth.info.phone
      user.gender = auth.info.gender
      user.birth_date = auth.info.birthday
      user.document_number = auth.info.document_number
      user.document_expiry = auth.info.document_expiry
      user.document_photo = auth.info.document_photo
    end
  end
end
