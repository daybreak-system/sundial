require "./spec_helper"

describe Sundial::Applets::Cat do
  describe ".main" do
    it "copies from STDIN to STDOUT when given no operands" do
      stdin_buffer = IO::Memory.new "hello sekai"
      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdin: stdin_buffer,
        stdout: stdout_buffer
      )

      exit_code = Sundial::Applets::Cat.main(ctx)
      stdin_buffer.close

      stdout_buffer.to_s.should eq "hello sekai"
      exit_code.should eq(0)
    end

    it "copies the file to STDOUT when given a single file as operand" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: [tmpfile.path])

      exit_code = Sundial::Applets::Cat.main(ctx)

      stdout_buffer.to_s.should eq "hello sekai\n"
      exit_code.should eq(0)
    end

    it "concatenates multiple files to STDOUT when given multiple files as operands" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.close

      tmpfile1 = File.tempfile("sundial-spec1")
      tmpfile1.puts "i luv u"
      tmpfile1.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: [tmpfile.path, tmpfile1.path])

      exit_code = Sundial::Applets::Cat.main(ctx)

      stdout_buffer.to_s.should eq "hello sekai\ni luv u\n"
      exit_code.should eq(0)
    end
  end
end
