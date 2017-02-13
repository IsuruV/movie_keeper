class UsersController < ApplicationController

  def create
    # binding.pry
    @user = User.find_or_create_by(user_params)
    # respond_to do |format|
    #   format.json {render json: @user.to_json}
    # end
    render json: @user.to_json
  end

  private
  def user_params
    params.require(:user).permit(:fb_id, :first_name, :last_name, :email, :movie)
  end
end
