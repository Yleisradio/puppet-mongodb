source "https://rubygems.org"

gem "puppet", ENV['PUPPET_VERSION'] || ">= 3.3"

group :test do
  gem "rake"
  gem "mocha"
  gem "puppet-lint"
  # REVIEW: OnTheEdgeHere - See: https://github.com/rodjek/rspec-puppet/issues/56
  gem "rspec-puppet", :git => "https://github.com/rodjek/rspec-puppet.git"
  gem "librarian-puppet"
end
