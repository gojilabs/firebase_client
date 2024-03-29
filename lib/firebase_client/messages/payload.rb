# frozen_string_literal: true

module FirebaseClient
  module Messages
    # The place to store push notification payload templates
    class Payload < BaseService
      DEFAULT_SOUND = 'default'

      # @param device_token [String] Firebase device token (registration ID)
      # @param title [String] notification title
      # @param body [String] notification body
      # @param data [Hash] hash with additional internal data that should be send within push notification
      # @param ios_sound [String] iOS sound
      # @param android_sound [String] Android sound
      # @param android_channel_id [String] allows to group notifications into channels and manage them together
      # @param badge [Integer] unread push notifications count
      def initialize(device_token:, title:, body:, data:, ios_sound:, android_sound:, android_channel_id:, badge:) # rubocop:disable Metrics/ParameterLists
        @device_token = device_token
        @title = title
        @body = body
        @data = data
        @ios_sound = ios_sound || DEFAULT_SOUND
        @android_sound = android_sound
        @android_channel_id = android_channel_id
        @badge = badge
        super
      end

      # @return [Hash] message payload
      def call
        payload = {
          token: @device_token,
          notification: {
            title: @title,
            body: @body
          },
          data: @data
        }

        payload.merge!(ios_options) if @ios_sound.present? || @badge.present?
        payload.merge!(android_options) if @android_sound.present? || @android_channel_id.present?

        payload
      end

      private

      def ios_options
        {
          apns: {
            payload: {
              aps: {
                sound: @ios_sound,
                badge: @badge
              }.compact
            }
          }
        }
      end

      def android_options
        {
          android: {
            notification: {
              sound: @android_sound,
              channel_id: @android_channel_id
            }.compact
          }
        }
      end
    end
  end
end
