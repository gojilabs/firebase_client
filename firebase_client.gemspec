# frozen_string_literal: true

require_relative 'lib/firebase_client/version'

Gem::Specification.new do |spec|
  spec.name = 'firebase_client'
  spec.version = FirebaseClient::VERSION
  spec.authors = ['Bohdan Malets']
  spec.email = ['bohdan@gojilabs.com']

  spec.summary = 'Firebase client gem'
  spec.description = 'Ruby gem with FCM support: easily sends push notifications to Firebase for smooth mobile device communication.' # rubocop:disable Layout/LineLength
  spec.required_ruby_version = '>= 3.2.2'

  spec.metadata['source_code_uri'] = 'https://github.com/gojilabs/firebase_client'
  spec.metadata['changelog_uri'] = 'https://github.com/gojilabs/firebase_client/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fcm', '~> 1.0.8'
  spec.add_dependency 'rails', '~> 7.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
