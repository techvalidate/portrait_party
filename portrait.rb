require 'rubygems'
require 'httparty'
require 'open-uri'
require 'fileutils'

class Portrait
  include HTTParty
  format :xml

  def self.url(url)
    Portrait.base_uri url
  end
  
  def self.authorize(username, password)
    Portrait.basic_auth username, password
  end

  def self.capture(url, dir, filename)
    raise 'Please provide a Portait endpoint' unless default_options[:base_uri]
    raise 'Set username and password'         unless default_options[:basic_auth]
    portrait = Portrait.post '/', :query=>{:url=>url}
    image = open "#{default_options[:base_uri]}#{portrait['site']['image_url']}"
    FileUtils.cp image.path, "#{dir}/#{filename}"
    return "#{dir}/#{filename}"
  rescue Net::HTTPFatalError
    raise 'Invalid url'
  end
end
