require "./spec_helper"

describe Sundial::Applets::Echo do
  describe ".main" do
    it "writes a <newline> when given no operands" do
      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: [] of String
      )

      exit_code = Sundial::Applets::Echo.main(ctx)

      stdout_buffer.to_s.should eq "\n"
      exit_code.should eq(0)
    end

    it "writes a single operand follow by a <newline>" do
      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: ["hello"]
      )

      exit_code = Sundial::Applets::Echo.main(ctx)

      stdout_buffer.to_s.should eq "hello\n"
      exit_code.should eq(0)
    end

    it "writes multiple operands seperated by single spaces followed by a <newline>" do
      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: ["hello", "sekai"]
      )

      exit_code = Sundial::Applets::Echo.main(ctx)

      stdout_buffer.to_s.should eq("hello sekai\n")
      exit_code.should eq(0)
    end
  end
end
