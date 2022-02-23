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
    http = Net::HTTP.new(uri.host, uri.port)
    # header = {'Content-Type': 'text/json'}
    user = {
      username: "user1",
      password: "randompassword"
    }
    p user.to_json

    @user = user
    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    # or should it be (uri.request_uri)
    request = Net::HTTP::Post.new(uri) 
    # request.header = header
    request['Content-Type']='application/json'
    request.body = user.to_json
    response = http.request(request)
    @response = response
end
  
Then('I receive valid HTTP response code {int}') do |expected_http_code|
    puts @response
    expect(@response.code).to eq(expected_http_code.to_s)
end
  
Then('I get info of that specific user') do
    user_response = JSON.parse(@response.body)
    p user_response.keys
    p user_response.values
    # should return the value of password
    # expected = user_response["username"].to_s
    p @user
    expect(user_response["username"].to_s).to eq(@user[:username])
end
