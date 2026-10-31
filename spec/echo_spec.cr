require "./spec_helper"

describe Sundial::Applets do
  describe "echo" do
    it "return a string" do
      Sundial::Applets.echo(["test", "thingy"]).should be_a(String)
    end
  end
end
