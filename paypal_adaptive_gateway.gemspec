# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "paypal_adaptive_gateway"
  s.version     = PaypalAdaptiveGateway::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Woodbridge, lamp"]
  s.email       = ["jwoodbridge@me.com"]
  s.homepage    = ""
  s.summary     = %q{Adaptive Payment support for ActiveMerchant}
  s.description = %q{Adaptive Payment support for ActiveMerchant}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'multi_json', '~> 1.0.0'
  s.add_runtime_dependency 'activemerchant', '~> 1.20.0'
  s.add_runtime_dependency 'rash', '~> 0.3.0'
  s.add_runtime_dependency 'money', '~> 3.7.0'
end
