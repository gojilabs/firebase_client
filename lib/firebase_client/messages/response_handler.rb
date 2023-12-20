# frozen_string_literal: true

module FirebaseClient
  module Messages
    class ResponseHandler < BaseService
      # @param response [Hash] FCM send message response
      def initialize(response:)
        @response = response
        super
      end

      def call
        @response[:canonical_ids] ||= []
        @response[:not_registered_ids] ||= []

        # replace outdated tokens with new up-to-date
        process_canonical_ids if canonical_ids?
        # remove invalid or expired device tokens
        process_not_registered_ids if not_registered_ids?
      end

      private

      def process_canonical_ids
        configuration.process_canonical_ids_block&.call(canonical_ids)
      end

      def process_not_registered_ids
        configuration.process_not_registered_ids_block&.call(not_registered_ids)
      end

      # @return [Array] Firebase canonical IDs data: [{old: <old token>, new: <new token>}, ...]
      def canonical_ids
        @canonical_ids ||= @response[:canonical_ids]
      end

      # @return [Array] Firebase not registered IDs: [<invalid token>, ...]
      def not_registered_ids
        @not_registered_ids ||= @response[:not_registered_ids]
      end

      def canonical_ids?
        canonical_ids.is_a?(Array) && !canonical_ids.empty?
      end

      def not_registered_ids?
        not_registered_ids.is_a?(Array) && !not_registered_ids.empty?
      end

      # @return [FirebaseClient::Configuration] gem configuration
      def configuration
        @configuration ||= ::FirebaseClient.configuration
      end
    end
  end
end
