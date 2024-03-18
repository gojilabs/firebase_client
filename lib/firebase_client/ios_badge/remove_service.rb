# frozen_string_literal: true

module FirebaseClient
  module IosBadge
    class RemoveService < BaseService
      # @param device_token [String] Firebase device token (registration ID)
      def initialize(device_token:)
        @device_token = device_token
        super
      end

      # @return [Hash] Firebase response
      def call
        UpdateService.call(device_token: @device_token, badge: 0)
      end
    end
  end
end
