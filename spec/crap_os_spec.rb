require "spec_helper"

describe CrapOS do
  it "has a VERSION" do
    CrapOS::VERSION.should =~ /^[\.\da-z]+$/
  end
end
