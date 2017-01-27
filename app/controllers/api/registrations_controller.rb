class Api::RegistrationsController < Api::BaseController
  skip_before_filter :authenticate_user_from_token!
  def create
    @user = User.new(user_params)
    @auth_token = jwt_token(@user) if @user.save
    # user_params['password']
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :provider, :uid, :name)
  end

end
