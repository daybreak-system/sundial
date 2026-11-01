module Sundial
  struct Context
    property stdin : IO
    property stdout : IO
    property stderr : IO
    property argv : Array(String)

    def initialize(@stdin = STDIN, @stdout = STDOUT, @stderr = STDERR, @argv = ARGV)
    end
  end
end
