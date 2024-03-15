# frozen_string_literal: true

module FirebaseClient
  module Messages
    class SendService < BaseService
      # @param device_token [String] Firebase device token (registration ID)
      # @param title [String] notification title
      # @param body [String] notification body
      # @param data [Hash] hash with additional internal data that should be send within push notification
      # @param ios_sound [String] iOS sound
      # @param android_sound [String] Android sound
      # @param android_channel_id [String] allows to group notifications into channels and manage them together
      # @param badge [Integer] unread push notifications count
      def initialize(device_token:, title:, body:, data:, ios_sound: nil, android_sound: nil, android_channel_id: nil, badge: nil) # rubocop:disable Metrics/ParameterLists
        @device_token = device_token
        @title = title
        @body = body
        @data = data
        @ios_sound = ios_sound
        @android_sound = android_sound
        @android_channel_id = android_channel_id
        @badge = badge
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
        @payload ||= Payload.call(device_token: @device_token,
                                  title: @title,
                                  body: @body,
                                  data: @data,
                                  ios_sound: @ios_sound,
                                  android_sound: @android_sound,
                                  android_channel_id: @android_channel_id,
                                  badge: @badge)
      end
    end
  end
end
