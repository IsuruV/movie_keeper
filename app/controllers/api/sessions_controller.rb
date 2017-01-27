class Api::SessionsController < Api::BaseController
  skip_before_filter :authenticate_user_from_token!
  before_filter :ensure_params_exist

  def create
    @user = User.find_for_database_authentication(email: user_params[:email])
    return invalid_login_attempt unless @user
    return invalid_login_attempt unless @user.valid_password?(user_params[:password])
    @auth_token = jwt_token(@user)
    @user.token = @auth_token
    @user.save
  end

  # def create
  # @user = User.find_for_database_authentication(email: user_params[:email])
  # return invalid_login_attempt unless @user
  # return invalid_login_attempt unless @user.valid_password?(user_params[:password])
  # @auth_token = jwt_token({ email: @user.email})
  # end

  def destroy
    current_user.token = ''
    current_user.save
    sign_out(current_user)
    current_user = nil
    render :json => current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def ensure_params_exist
    if user_params[:email].blank? || user_params[:password].blank?
      return render_unauthorized errors: { unauthenticated: ["Incomplete credentials"] }
    end
  end

  def invalid_login_attempt
    render_unauthorized errors: { unauthenticated: ["Invalid credentials"] }
  end
end
