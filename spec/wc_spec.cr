require "./spec_helper"

describe Sundial::Applets::Wc do
  describe ".main" do
    it "writes to STDOUT the number of lines followed by the given file's path when given a file and the '-l' flag" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.puts "i luv u"
      tmpfile.puts "blessing to the world"
      tmpfile.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: ["-l", tmpfile.path]
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "3 #{tmpfile.path}\n"
      exit_code.should eq(0)
    end

    it "writes to STDOUT the number of bytes followed by the given file's path when given a file and the '-c' flag" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.puts "i luv u"
      tmpfile.puts "blessing to the world"
      tmpfile.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: ["-c", tmpfile.path]
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "42 #{tmpfile.path}\n"
      exit_code.should eq(0)
    end

    it "writes to STDOUT the number of words followed by the given file's path when given a file and the '-w' flag" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.puts "i luv u"
      tmpfile.puts "blessing to the world"
      tmpfile.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: ["-w", tmpfile.path]
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "9 #{tmpfile.path}\n"
      exit_code.should eq(0)
    end

    it "writes to STDOUT the number of lines, words and bytes, followed by the given file's path when given a file and no flags" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.puts "i luv u"
      tmpfile.puts "blessing to the world"
      tmpfile.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: [tmpfile.path]
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "3 9 42 #{tmpfile.path}\n"
      exit_code.should eq(0)
    end

    it "writes to STDOUT the number of lines, words and bytes, followed by the given file's path when given a file and the '-lwc' flags" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.puts "i luv u"
      tmpfile.puts "blessing to the world"
      tmpfile.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: [tmpfile.path]
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "3 9 42 #{tmpfile.path}\n"
      exit_code.should eq(0)
    end

    it "writes to STDOUT the number of lines, words and bytes, followed by the associated file's path seperated by <newline> characters when given multiple files and no flags" do
      tmpfile = File.tempfile("sundial-spec")
      tmpfile.puts "hello sekai"
      tmpfile.puts "i luv u"
      tmpfile.puts "blessing to the world"
      tmpfile.close

      tmpfile1 = File.tempfile("sundial-spec1")
      tmpfile1.puts "ハロー・ワールド"
      tmpfile1.puts "愛してるよ"
      tmpfile1.puts "世界に祝福を"
      tmpfile1.close

      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdout: stdout_buffer,
        argv: [tmpfile.path, tmpfile1.path]
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "3 9 42 #{tmpfile.path}\n3 3 60 #{tmpfile1.path}\n6 12 102 total\n"
      exit_code.should eq(0)
    end

    it "writes to STDOUT the number of lines, words and bytes in STDIN when given no files and no flags" do
      stdin_buffer = IO::Memory.new "hello sekai\ni luv u\nblessing to the world"
      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdin: stdin_buffer,
        stdout: stdout_buffer,
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "3 9 42\n"
      exit_code.should eq(0)
    end

    it "writes to STDOUT the number of lines, words and bytes in STDIN when given no files and '-' as an operand" do
      stdin_buffer = IO::Memory.new "hello sekai\ni luv u\nblessing to the world"
      stdout_buffer = IO::Memory.new

      ctx = Sundial::Context.new(
        stdin: stdin_buffer,
        stdout: stdout_buffer,
        argv: ["-"]
      )

      exit_code = Sundial::Applets::Wc.main(ctx)

      stdout_buffer.to_s.should eq "3 9 42\n"
      exit_code.should eq(0)
    end
  end
end
