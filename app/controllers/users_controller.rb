class UsersController < ApplicationController
  before_filter :authenticate_user_from_token!, except: [:create]
  def create
    # binding.pry
    @user = User.find_or_create_by(user_params)
    @user.save
    respond_to do |format|
      format.json {render json: @user.to_json}
    end
  end

  private
  def user_params
    params.require(:user).permit(:fb_id, :first_name, :last_name, :email)
  end
end
