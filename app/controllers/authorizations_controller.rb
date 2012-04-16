class AuthorizationsController < Devise::OmniauthCallbacksController 
  def vkontakte
  	auth = request.env["omniauth.auth"]
    authorization = Authorization.find_by_uid_and_provider(auth["uid"].to_s, auth["provider"])
  	if current_user
      current_user.authorizations.create!(:uid => auth["uid"],:provider => auth["provider"], :name => auth["info"]["name"])
      sign_in_and_redirect(:user, current_user)
    elsif !current_user && authorization
      @user=authorization.user
      sign_in_and_redirect(:user, @user)
    else
      @user = User.new
      @user.create_with_session(auth)
      if @user.save
        sign_in_and_redirect(:user, @user)
      else
        session[:omniauth] = auth.except("extra")
        redirect_to new_user_registration_path
      end
    end
  end

  def create
  end

  def index
  end

  def destroy
  end
end
