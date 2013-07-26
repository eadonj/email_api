require 'sinatra'
require 'pony'
require 'json'

configure :production do
	set :email_options, {
		via: :smtp,
	  via_options: {
	    address: 'smtp.sendgrid.net',
	    port: '587',
	    domain: 'heroku.com',
	    user_name: ENV['SENDGRID_USERNAME'],
	    password: ENV['SENDGRID_PASSWORD'],
	    authentication: :plain,
	    enable_starttls_auto: true
	  }
	}
end


post '/' do
	content_type :json
  content = JSON.parse(request.body.read)
  recipient = content["to"].match(/.*<(.*)>/)[1]
  Pony.mail to: recipient, from: "noreply@example.com", 
				  	subject: content['subject'], body: content['body']
end