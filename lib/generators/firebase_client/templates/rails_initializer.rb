# frozen_string_literal: true

FirebaseClient.setup do |config|
  # Ensure you have these ENV variables from your Firebase settings
  # Or update the following three lines with your own values if ENV variables aren't used
  config.project_id = ENV.fetch('FIREBASE_PROJECT_ID')
  config.api_key = ENV.fetch('FIREBASE_API_KEY')
  config.credentials_json_in_base64 = ENV.fetch('FIREBASE_CREDENTIALS_JSON_IN_BASE64')

  # By default, the gem utilizes the Rails logger, but this can be customized as needed
  config.logger = Rails.logger
  # The gem will write the request payload and response body to the logs if this setting is enabled
  config.debug_mode = !Rails.env.production?

  # canonical IDs is an array [{old: <old token>, new: <new token>}, ...]
  config.process_canonical_ids do |canonical_ids|
    # Implement logic here to update outdated device tokens in your database
    # with the latest ones received from Firebase.
    # Find an example below:
    #
    # canonical_ids.each do |canonical_data|
    #   InstalledApp.where(device_token: canonical_data[:old])
    #               .update_all(device_token: canonical_data[:new])
    # end
  end

  # not registered IDs is an array [<invalid token>, ...]
  config.process_not_registered_ids do |not_registered_ids|
    # Implement logic here to remove invalid device tokens from your database
    # based on the data received from Firebase response.
    # An example can be found below:
    #
    # InstalledApp.where(device_token: not_registered_ids).destroy_all
  end
end
