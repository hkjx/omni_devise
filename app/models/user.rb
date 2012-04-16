class User < ActiveRecord::Base
	has_many :authorizations
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  def create_with_session(data_token)
  	authorizations.build(:uid => data_token["uid"],:provider => data_token["provider"], :name => data_token["info"]["name"])
  end
  def password_required?
  	authorizations.empty? || !password.blank?
  end
end
