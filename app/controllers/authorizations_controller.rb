class AuthorizationsController < Devise::OmniauthCallbacksController 
  def vkontakte
    authorize_with_omni
  end

  def twitter
    authorize_with_omni
  end

  def facebook
    authorize_with_omni 
  end

private
  def authorize_with_omni
  	auth = request.env["omniauth.auth"]
    authorization = Authorization.find_by_uid_and_provider(auth["uid"].to_s, auth["provider"])
  	if current_user
      current_user.authorizations.create!(:uid => auth["uid"],:provider => auth["provider"], :name => auth["info"]["name"])
      sign_in_and_redirect(:user, current_user)
    elsif !current_user && authorization
      @user=authorization.user
      session[:auth_id]= authorization.id
      sign_in_and_redirect(:user, @user)
    else
      @user = User.new
      @user.create_with_session(auth)
      @user.email = auth["info"]["email"] unless auth["info"]["email"].blank?
      if @user.save
        session[:auth_id]= @user.authorizations.first.id
        sign_in_and_redirect(:user, @user)
      else
        session[:omniauth] = auth.except("extra")
        redirect_to new_user_registration_path
      end
    end
  end

end
