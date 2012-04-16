class Authorization < ActiveRecord::Base
	belongs_to :user
  attr_accessible :name, :provider, :uid, :user_id
end
