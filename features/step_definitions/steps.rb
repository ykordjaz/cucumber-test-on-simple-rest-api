require "net/http"
require "uri"

# Given('the service is running') do
#     uri = URI.parse('http://127.0.0.1:3000/api/v1/healthcheck')
    
#     http = Net::HTTP.new(uri.host, uri.port)
#     get_healthcheck_request = Net::HTTP::Get.new(uri.request_uri)
#     # Get.new creates a new request object
#     response = http.request(get_healthcheck_request)
#     expect(response.code).to eq "200"
#   end
  
#   When('I send GET HTTP request') do
#     uri = URI.parse('http://127.0.0.1:3000/api/v1/users')
    
#     http = Net::HTTP.new(uri.host, uri.port)
#     get_users = Net::HTTP::Get.new(uri.request_uri)
#     # Get.new creates a new request object and store it in an instance var
    
#     response = http.request(get_users)
#     @response = response
#     # expect(response.code).to eq "200"

#   end
  
#   Then('I receive valid HTTP response code {int}') do |expected_http_code|
#     expect(@response.code).to eq(expected_http_code.to_s)
#   end
  
#   Then('I get a list of all users') do
#     expect(@response.body).to eq "[]"
#   end
  


#  this is for the POST method

Given('the service is running') do
    uri = URI.parse('http://127.0.0.1:3000/api/v1/healthcheck')
    
    http = Net::HTTP.new(uri.host, uri.port)
    get_healthcheck_request = Net::HTTP::Get.new(uri.request_uri)
    # Get.new creates a new request object
    response = http.request(get_healthcheck_request)
    expect(response.code).to eq "200"
end
  
  
When('I send POST HTTP request') do
    
    uri = URI.parse('http://127.0.0.1:3000/api/v1/users')
    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    # or should it be (uri.request_uri)
    request_with_user_data = Net::HTTP::Post.new(uri) 
    request_with_user_data['Content-Type']='application/json'
    
    user = {
      username: "user1",
      password: "randompassword"
    }
    # to print out info about an object using p (below)
    # p user.to_json
    @user = user
    # storing user information in the HTTP POST request body in JSON format
    request_with_user_data.body = user.to_json
    # executing the HTTP POST request against HTTP endpoint. 
    # the .request method is like "send" on postman.
    response = http.request(request_with_user_data)
    # storing response as instance variable to be accessed later
    @response = response
end
  
Then('I receive valid HTTP response code {int}') do |expected_response_code|
    # response.code is the 200, 400, etc code and it's a string.
    expect(@response.code).to eq(expected_response_code.to_s)
end
  
Then('I get info on that specific user') do
    # the response body is a big string (JSON) and it should be converted into a Ruby object = a hash in this case - through parsing. "user_response" is a hash
    user_response = JSON.parse(@response.body)
    p @user.class
    # p "user_response is a #{user_response.class}" => prints Hash
    # p user_response.keys
    # p user_response.values
    # should return the value of username. it's already a string. the second part : the keys of "user" are symbols, so it should be indexed as a symbol with [:blahblah]
    expect(user_response["username"]).to eq(@user[:username])

    # HASH  hashtable   or   dictionary
    # KEYS   =>   VALUES
    # word  =>   meaning

    # Hash that maps String =>  String    user_response
    # Hash that maps Symbol =>  String    @user


    # String   "akjsajdjsajd"
    # Symbol   "ksksks"

    # # How to create a symbol
    # i_am_symbol = :hello
    # i_am_symbol_too = "hello".to_sym
   
end
