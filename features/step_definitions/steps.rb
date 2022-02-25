require "net/http"
require "uri"
# require "json_matchers/rspec"


Given('the service is running') do
  uri = URI.parse('http://127.0.0.1:3000/api/v1/healthcheck')
  
  http = Net::HTTP.new(uri.host, uri.port)
  # Get.new creates a new request object
  get_healthcheck_request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(get_healthcheck_request)
  expect(response.code).to eq "200"
end
  

# to fetch all users
When('I send GET HTTP request') do
    uri = URI.parse('http://127.0.0.1:3000/api/v1/users')
    
    http = Net::HTTP.new(uri.host, uri.port)
    # Get.new creates a new request object and store it in an instance variable
    # "get_users" in this case could also be called "request"
    get_users = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(get_users)
    # could lines 22 & 23 be written together like this? 
    # response = Net::HTTP.get_response(uri)
    @response = response
    # expect(response.code).to eq "200"

end
  
Then('I receive valid HTTP response code {int}') do |expected_response_code|
    # @response.code is the 200, 400, etc code and it's a "string".
    expect(@response.code).to eq(expected_response_code.to_s)
end

Then('I get a list of all users') do
    # below we convert the hash with strings into a json (so index 0 is a whole object with user details and so on, not just the first element of a string)
    # so user_response[0] => # {"id"=>2, "username"=>"Yas", "password"=>"Pass", "created_at"=>"2022-02-23T14:21:17.929Z", "updated_at"=>"2022-02-23T14:21:17.929Z"}
    user_response = JSON.parse(@response.body)
    expect(user_response.size).to be > 0
    # expect(user_response).to match_response_schema("user")


end
  

# #  this is for the POST method
  
When('I send POST HTTP request') do
    
    uri = URI.parse('http://127.0.0.1:3000/api/v1/users')
    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    # or should it be (uri.request_uri)?
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

    # could I have also done lines 47-57 this way? :
    # uri = URI('http://127.0.0.1:3000/api/v1/users')
    # response = Net::HTTP.post_form(uri, 'username' => 'user1', 'password' => 'randompassword', 'userID' => 1)
end
  
Then('I get info on that specific user') do
    # the response body is a big string (JSON) and it should be converted into a Ruby object = a hash in this case - through parsing => "user_response" is a hash
    @user_response = JSON.parse(@response.body)
    # p @user.class
    # p "user_response is a #{user_response.class}" => prints Hash
    # p user_response.keys
    # p user_response.values
    # should return the value of username. it's already a string. the second part : the keys of "user" are symbols, so it should be indexed as a symbol with [:blahblah]
    expect(@user_response["username"]).to eq(@user[:username])

    # HASH  hashtable   or   dictionary
    # KEYS   =>   VALUES
    # word  =>   meaning/definition

    # Hash that maps String =>  String    user_response
    # Hash that maps Symbol =>  String    @user


    # String   "akjsajdjsajd"
    # Symbol   "ksksks"

    # # How to create a symbol
    # i_am_symbol = :hello
    # i_am_symbol_too = "hello".to_sym
end


# this is for the PUT method

When('I send PUT HTTP request') do
    uri = URI.parse('http://127.0.0.1:3000/api/v1/users/5')
    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri) 
    request['Content-Type']='application/json'
    @request = request
        
    updated_user = ' { "username": "user2", "password": "randompassword" } '
    request.body = updated_user
    updated_request = Net::HTTP::Get.new(uri)
    response = http.request(updated_request)
    @response = response
    @updated_user = updated_user
end

  Then('I get the info on the updated user') do
    @user_response = JSON.parse(@response.body)  
    # parsed the updated_user too, because otherwise it can't turn it into a hash and access the keys & values, and instead just reads the liteal string values e.g. "username" is "username", not the value "user2"
    @updated_user = JSON.parse(@response.body)  
    # p @user_response
    # {"id"=>5, "username"=>"user2", "password"=>"randompassword", "created_at"=>"2022-02-23T16:11:20.335Z", "updated_at"=>"2022-02-24T17:21:00.242Z"}
    # p @updated_user
    # " { \"username\": \"user2\", \"password\": \"randompassword\" } "
    expect(@user_response["username"]).to eq(@updated_user["username"])
end
  
# This is for the DELETE method

When('I send DELETE HTTP request') do
# #   Delete is a CLASS, not a method
#     request = Net::HTTP.new('http://127.0.0.1:3000/api/v1/users/2').delete('/path') 

    uri = URI('http://127.0.0.1:3000/api/v1/users/4')
    http = Net::HTTP.new(uri.host, uri.port)
    @req = Net::HTTP::Delete.new(uri.path)
    @response = http.request(@req)
    puts "deleted #{@response}"
    @updated_request = Net::HTTP::Get.new(uri)
    @updated_response = http.request(@updated_request)
end
  
  Then('I receive HTTP response code {int}') do |int|
    expect(@updated_response.code).to eq "404"
  end
  