require 'rubygems'
require 'httparty'

class Portrait
  include HTTParty
  base_uri 'localhost:3000'
  basic_auth 'username', 'password'
end
 
puts Portrait.post '/', :query=>{:url=>'http://github.com'}
#puts response.body, response.code, response.message, response.headers.inspect