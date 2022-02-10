class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :no_good

  def create
    user = User.create!(user_params)

    session[:user_id] = user.id
    render json: user, status: :created
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

  def no_good(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
