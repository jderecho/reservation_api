class AuthenticationController < ApplicationController
  skip_before_action :authenticate, only: :login

  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, "HS256")
      render json: { status: "success", token: token }
    else
      render json: { status: "error", message: "Invalid username or password" }, status: :unauthorized
    end
  end
end
