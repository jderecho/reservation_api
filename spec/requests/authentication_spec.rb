require 'swagger_helper'

RSpec.describe 'authentication', type: :request do
  path '/auth/login' do
    let(:auth_user) { create(:user, username: 'testuser', password: 'testpass') }

    post('login authentication') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        }
      }

      response '200', 'successful' do
        let(:user) { { username: auth_user.username, password: auth_user.password } }

        schema type: :object,
          properties: {
            status: { type: :string },
            token: { type: :string }
          }
        run_test!
      end
    end
  end
end
