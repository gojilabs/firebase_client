# frozen_string_literal: true

module FirebaseClient
  module IosBadge
    class UpdateService < BaseService
      # @param device_token [String] Firebase device token (registration ID)
      # @param badge [Integer] unread push notifications count
      def initialize(device_token:, badge:)
        @device_token = device_token
        @badge = badge
        super
      end

      # @return [Hash] Firebase response
      def call
        Messages::SendService.call(device_token: @device_token,
                                   title: '',
                                   body: '',
                                   data: {},
                                   badge: @badge)
      end
    end
  end
end
