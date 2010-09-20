require 'rubygems'
require 'rspec'

before :all do
  Rails.env = 'test'
  @gateway = ActiveMerchant::Billing::PaypalAdaptiveGateway.new
end

describe 'making payments' do
  
end

describe "refunds" do
  
end

describe "preapproval requests" do
  
end