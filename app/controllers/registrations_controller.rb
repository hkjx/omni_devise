class RegistrationsController < Devise::RegistrationsController
  def create
  	super
  	session[:omniauth]=nil unless @user.new_record?
  	session[:auth_id] = @user.authorizations.first.id unless @user.authorizations.empty?
  end

	private

	def build_resource(*args)
		super
		if session[:omniauth]
			@user.create_with_session(session[:omniauth])
			@user.valid?
		end
	end
end
