require "rubygems"
require "bundler/setup"
require "rspec-puppet"

fixture_path = File.expand_path(File.join(__FILE__, "..", "fixtures"))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, "modules")
  c.manifest_dir = File.join(fixture_path, "manifests")
  c.manifest = File.join(fixture_path, "manifests", "site.pp")

  c.default_facts = {
    :osfamily => "Debian",
    :operatingsystem => "Ubuntu",
    :lsbdistcodename => "precise",
    :lsbdistdescription => "Ubuntu 12.04 LTS",
    :lsbdistid => "Ubuntu",
    :lsbdistrelease => "12.04",
    :lsbmajdistrelease => "12",
  }
end
