require "spec_helper"

RSpec.describe Appbooster::Server do
  it "has a version number" do
    expect(Appbooster::Server::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
