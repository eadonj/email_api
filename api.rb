require 'sinatra'
require 'pony'
require 'json'


post '/' do
	content_type :json
  content = JSON.parse(request.env["rack.request.form_vars"])
  recipient = content["to"].match(/.*<(.*)>/)[1]
  Pony.mail to: recipient, 
				  	from: "noreply@example.com", 
				  	subject: content['subject'], 
				  	body: content['body'],
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
	
end