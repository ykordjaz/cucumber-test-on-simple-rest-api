# define a custom RSpec matcher that validates the response object in our request spec against a specified JSON schema:
# require "json_matchers/rspec"
# require 'rspec'
# require 'rails_helper'
require 'rspec/expectations'

RSpec::Matchers.define :match_response_schema do |schema|
    match do |response|
        schema_directory = "#{Dir.pwd}/features/spec/support/schemas"
        # schema_directory = '/home/yasmin/cucumber-rest-api-test/features/spec/support/schemas'
        schema_path = "#{schema_directory}/#{schema}.json"
        p Dir[schema_directory+'/*']
        p File.exist?(schema_path)  # returns true
        # First parameter is either a file path or the actual schema itself
        # for some reason without line 16, the file couldn't be loaded/found
        schema = File.read(schema_path)
        JSON::Validator.validate!(schema, response.body, strict: true)
    end
end
  