source "https://rubygems.org"
puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']

gem "puppet", puppetversion

group :test do
  gem "rake"
  gem "mocha"
  gem "puppet-lint"
  # REVIEW: OnTheEdgeHere - See: https://github.com/rodjek/rspec-puppet/issues/56
  gem "rspec-puppet", :git => "https://github.com/rodjek/rspec-puppet.git"
end