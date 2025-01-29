class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  rescue_from StandardError, with: :handle_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      key = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
      puts token
      puts key
      key
    rescue JWT::DecodeError
      false
    end
  end

  def handle_error(exception)
    render json: { 
      status: 'error',
      message: 'Internal server error',
      error: exception.message 
    }, status: :internal_server_error
  end

  def handle_not_found(exception)
    render json: { 
      status: 'error',
      message: 'Resource not found',
      error: exception.message 
    }, status: :not_found
  end

  def handle_parameter_missing(exception)
    render json: { 
      status: 'error',
      message: 'Missing required parameters',
      error: exception.message 
    }, status: :unprocessable_entity
  end
end
