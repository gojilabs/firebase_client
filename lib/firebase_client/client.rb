# frozen_string_literal: true

module FirebaseClient
  class Client
    # @param payload [Hash] push notification payload
    # @return [Hash] Firebase response
    def send_message(payload)
      response = fcm_client.send_notification_v1(payload)
      log_response(payload:, response:) if configuration.debug_mode

      response
    end

    class << self
      # @param payload [Hash] push notification payload
      # @return [Hash] Firebase response
      delegate :send_message, to: :new
    end

    protected

    # @return [FirebaseClient::Configuration] gem configuration
    def configuration
      @configuration ||= ::FirebaseClient.configuration
    end

    # @return [FCM] firebase client
    def fcm_client
      @fcm_client ||= ::FCM.new(configuration.api_key, json_key_path, configuration.project_id)
    end

    # could be a path to credentials.json file downloaded from GCP or StringIO (gem "fcm" accepts both options)
    def json_key_path
      StringIO.new(decode_credentials)
    end

    # NOTE: necessary because firebase credentials are in JSON format and values contains "\n".
    # ENV variable loading automatically removes "\n" which breaks Firebase authentication
    def decode_credentials
      Base64.decode64(configuration.credentials_json_in_base64)
    end

    def log_response(payload:, response:)
      configuration.logger&.info "[FIREBASE_CLIENT] request payload: #{payload}, response: #{response}"
    end
  end
end
