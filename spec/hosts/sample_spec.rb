require "spec_helper"

describe "sample.org", :type => :host do
  let(:node) { "sample.org"}

  it { should contain_file("/etc/mongod_sample.conf").with_content(/dbpath=\/data\/mongod_sample/) }
end