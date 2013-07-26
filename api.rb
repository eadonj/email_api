require 'sinatra'
require 'pony'
require 'json'

post '/' do
  content_type :json
  content = JSON.parse(request.env["rack.request.form_vars"])
  recipeient = content["to"].match(/.*<(.*)>/)[1]
  Pony.mail to: recipeient,
            from: 'noreply@example.com',
            subject: content['subject'],
            body: content['body']
end