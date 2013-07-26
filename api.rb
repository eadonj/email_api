require 'sinatra'
require 'pony'
require 'json'

configure :production do
  email_options, {      
    :from => "noreply@example.com",
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    },
  }
end


post '/' do
  content_type :json
  content = JSON.parse(request.env["rack.request.form_vars"])
  recipient = content["to"].match(/.*<(.*)>/)[1]
  Pony.options = settings.email_options
  Pony.mail(to: recipient, subject: content['subject'], body: content['body'])
end