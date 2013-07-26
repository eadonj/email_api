require './api.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'Email Api App' do
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end
  
  before(:each) do
		Pony.stub!(:deliver)
	end
	
	it 'sends email' do 
    Pony.should_receive(:deliver) do |mail|
    	mail.to.should == ['example@gmail.com']
    	mail.from.should ['noreply@example.com']
    	mail.subject.should == 'hi'
    	mail.body.should == 'hello email world'
    end
    Pony.mail(to: 'example@gmail.com', from: "noreply@example.com", subject: 'hi', body: 'hello email world')
	end
end