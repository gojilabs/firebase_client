# frozen_string_literal: true

module FirebaseClient
  class Configuration
    attr_accessor :project_id,
                  :api_key,
                  :credentials_json_in_base64,
                  :logger,
                  :debug_mode

    attr_reader :process_canonical_ids_block, :process_not_registered_ids_block

    def initialize
      @project_id = nil
      @api_key = nil
      @credentials_json_in_base64 = nil
      @process_canonical_ids_block = nil # it's a block
      @process_not_registered_ids_block = nil # it's a block
      @logger = nil
      @debug_mode = false
    end

    def process_canonical_ids(&block)
      @process_canonical_ids_block = block if block
    end

    def process_not_registered_ids(&block)
      @process_not_registered_ids_block = block if block
    end
  end
end
