# frozen_string_literal: true

module FirebaseClient
  module Messages
    # The place to store push notification payload templates
    module Payload
      # @param device_token [String] Firebase device token (registration ID)
      # @param title [String] notification title
      # @param body [String] notification body
      # @param data [Hash] hash with additional internal data that should be send within push notification
      def default_payload(device_token:, title:, body:, data:)
        {
          token: device_token,
          notification: {
            title:,
            body:
          },
          data:,
          apns: {
            payload: {
              aps: {
                sound: 'default'
              }
            }
          },
          android: {
            notification: {
              sound: 'default'
            }
          }
        }
      end

      # add payload for custom messages here later, for example
      # def my_message_with_icon(token:, icon: <icon path>, title:, body:, data:); end
    end
  end
end
