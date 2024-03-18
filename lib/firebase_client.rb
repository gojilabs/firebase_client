# frozen_string_literal: true

# dependencies
require 'fcm'
# gem files
require_relative 'firebase_client/version'
require_relative 'firebase_client/base_service'
require_relative 'firebase_client/configuration'
require_relative 'firebase_client/client'
require_relative 'firebase_client/messages/payload'
require_relative 'firebase_client/messages/response_handler'
require_relative 'firebase_client/messages/send_service'
require_relative 'firebase_client/ios_badge/remove_service'
require_relative 'firebase_client/ios_badge/update_service'

module FirebaseClient
  class << self
    attr_accessor :configuration

    def setup
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
