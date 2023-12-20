# frozen_string_literal: true

module FirebaseClient
  module Messages
    class SendService < BaseService
      include Payload

      # @param device_token [String] Firebase device token (registration ID)
      # @param title [String] notification title
      # @param body [String] notification body
      # @param data [Hash] hash with additional internal data that should be send within push notification
      def initialize(device_token:, title:, body:, data:)
        @device_token = device_token
        @title = title
        @body = body
        @data = data
        super
      end

      # @return [Hash] Firebase response
      def call
        response = Client.send_message(payload)

        ResponseHandler.call(response:)
        response
      end

      private

      def payload
        @payload ||= default_payload(device_token: @device_token, title: @title, body: @body, data: @data)
      end
    end
  end
end
