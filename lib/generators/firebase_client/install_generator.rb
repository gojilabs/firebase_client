# frozen_string_literal: true

require 'rails/generators'

module FirebaseClient
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        copy_file 'rails_initializer.rb', 'config/initializers/firebase_client.rb'
      end
    end
  end
end
