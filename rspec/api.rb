require_relative 'spec_helper'
require './api.rb'
require 'rspec'
require 'rack/test'

set :environment, :test


describe 'Email Api App' do

	def post_data
		{
			to: '"jared grippe" <jared@deadlyicon.com>',
			subject: "hello there",
			body: "i like frogs",
		}
	end

	context "when a good json object is posted" do

		let(:post_json){ post_data.to_json }

		it 'should send an email' do 
	    Pony.should_receive(:mail).with({
	    	to: '"jared grippe" <jared@deadlyicon.com>', 
			  from: "noreply@example.com", 
		  	subject: "hello there",
		  	body: "i like frogs",
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
	    })

			post '/', post_json

		end
	end


end