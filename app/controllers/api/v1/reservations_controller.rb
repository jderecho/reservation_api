module Api
  module V1
    class ReservationsController < ApplicationController
      # POST /api/v1/reservations
      def create
        parsed_data = ReservationPayloadParser.parse(request.raw_post)
        reservation = ReservationBuilder.new(parsed_data).save

        render json: {
          status: "success",
          reservation: ReservationSerializer.new(reservation).as_json
        }, status: :created
      rescue JSON::ParserError
        render json: {
          status: "error",
          message: "Invalid JSON payload"
        }, status: :bad_request
      rescue ReservationPayloadParser::InvalidFormatError => e
        render json: {
          status: "error",
          message: "Unsupported payload format",
          error: e.message
        }, status: :unprocessable_entity
      end
    end
  end
end
