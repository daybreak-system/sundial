module Sundial
  struct Context
    property stdin : IO
    property stdout : IO
    property stderr : IO
    property argv : Array(String)
    property exit_code : Int32 = 0

    def initialize(@stdin = STDIN, @stdout = STDOUT, @stderr = STDERR, @argv = ARGV)
    end

    def exit(code : Int32)
      @exit_code = code
    end
  end
end
