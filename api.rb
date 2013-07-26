require 'sinatra'
require 'pony'
require 'json'

post '/' do
  content_type :json
  Pony.mail(:to => 'eadonj@gmail.com', :from => 'noreply@example.com', :subject => "subject", :body => "body")
end

