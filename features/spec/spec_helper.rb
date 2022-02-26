# define a custom RSpec matcher that validates the response object in our request spec against a specified JSON schema:
# require "json_matchers/rspec"
# require 'rspec'
# require 'rails_helper'
# require 'rspec/expectations'

# RSpec::Matchers.define :match_response_schema do |schema|
#     match do |response|
#       schema_directory = "#{Dir.pwd}/spec/support/api/schemas"
#       schema_path = "#{schema_directory}/#{schema}.json"
#       JSON::Validator.validate!(schema_path, response.body, strict: true)
#     end
#   end
  