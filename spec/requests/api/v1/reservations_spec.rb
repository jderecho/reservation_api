require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, "HS256") }
  let(:Authorization) { "Bearer #{token}" }

  # {
  #   "start_date": "2021-03-12",
  #   "end_date": "2021-03-16",
  #   "nights": 4,
  #   "guests": 4,
  #   "adults": 2,
  #   "children": 2,
  #   "infants": 0,
  #   "status": "accepted",
  #   "guest": {
  #     "id": 1,
  #     "first_name": "Wayne",
  #     "last_name": "Woodbridge",
  #     "phone": "639123456789",
  #     "email": "wayne_woodbridge@bnb.com"
  #   },
  #   "currency": "AUD",
  #   "payout_price": "3800.00",
  #   "security_price": "500",
  #   "total_price": "4500.00"
  # }

  let(:reservation) do
    JSON.parse(File.read(Rails.root.join('spec/fixtures/reservation.json')))
    {
      start_date: Date.current.strftime('%Y-%m-%d'),
      end_date: (Date.current + 1.day).strftime('%Y-%m-%d'),
      guests: 4,
      nights: 4,
      adults: 2,
      children: 2,
      infants: 0,
      security_price: 500,
      payout_price: 3800.00,
      total_price: 4500.00,
      currency: 'AUD',
      status: 'accepted',
      guest: {
        id: 1,
        email: 'ayne_woodbridge@bnb.com',
        first_name: 'Wayne',
        last_name: 'Woodbridge',
        phone: '639123456789'
      }
    }
  end

  let(:reservation2) do
    {
      reservation: {
        start_date: Date.current.strftime('%Y-%m-%d'),
        end_date: (Date.current + 1.day).strftime('%Y-%m-%d'),
        expected_payout_amount: 3800.00,
        guest_details: {
          localized_description: '4 guests',
          number_of_adults: 2,
          number_of_children: 2,
          number_of_infants: 0
        },
        guest_email: 'wayne_woodbridge@bnb.com',
        guest_first_name: 'Wayne',
        guest_id: 1,
        guest_last_name: 'Woodbridge',
        guest_phone_numbers: [
          '639123456789',
          '639123456789'
        ],
        listing_security_price_accurate: 500.00,
        host_currency: 'AUD',
        nights: 4,
        number_of_guests: 4,
        status_type: 'accepted',
        total_paid_amount_accurate: 4500.00
      }
    }
  end

  path '/api/v1/reservations' do
    post 'create reservation' do
      tags 'Reservations'
      consumes 'application/json'
      produces 'application/json'
      security [ bearerAuth: [] ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Bearer token for authentication',
                required: true,
                schema: {
                  type: :string,
                  default: 'Bearer <token>'
                }

      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          start_date: { type: :string },
          end_date: { type: :string },
          nights: { type: :integer },
          guests: { type: :integer },
          adults: { type: :integer },
          children: { type: :integer },
          infants: { type: :integer },
          status: { type: :string },
          guest: {
            type: :object,
            properties: {
              id: { type: :integer },
              first_name: { type: :string },
              last_name: { type: :string },
              phone: { type: :string },
              email: { type: :string }
            }
          },
          currency: { type: :string },
          payout_price: { type: :number },
          security_price: { type: :number },
          total_price: { type: :number }
        }
      }

      parameter name: :reservation2, in: :body, schema: {
        type: :object,
        properties: {
          reservation: {
            type: :object,
            properties: {
              start_date: { type: :string },
              end_date: { type: :string },
              expected_payout_amount: { type: :number },
              guest_details: {
                type: :object,
                properties: {
                  localized_description: { type: :string },
                  number_of_adults: { type: :integer },
                  number_of_children: { type: :integer },
                  number_of_infants: { type: :integer }
                }
              },
              guest_email: { type: :string },
              guest_first_name: { type: :string },
              guest_id: { type: :integer },
              guest_last_name: { type: :string },
              guest_phone_numbers: {
                type: :array,
                items: { type: :string }
              },
              listing_security_price_accurate: { type: :number },
              host_currency: { type: :string },
              nights: { type: :integer },
              number_of_guests: { type: :integer },
              status_type: { type: :string },
              total_paid_amount_accurate: { type: :number }
            }
          }
        }
      }

      response '201', 'reservation created' do
        let(:Authorization) { "Bearer #{token}" }

        schema type: :object,
          properties: {
            id: { type: :integer },
            guest: {
              type: :object,
              properties: {
                id: { type: :integer },
                first_name: { type: :string },
                last_name: { type: :string },
                email: { type: :string }
              }
            },
            start_date: { type: :string },
            end_date: { type: :string },
            number_of_guests: { type: :integer },
            number_of_adults: { type: :integer },
            number_of_children: { type: :integer },
            number_of_infants: { type: :integer },
            security_price: { type: :number },
            payout_price: { type: :number },
            total_price: { type: :number },
            total_nights: { type: :integer },
            created_at: { type: :string }
          }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil } # Simulate missing token
        run_test!
      end
    end
  end
end
