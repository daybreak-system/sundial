require "./context"
require "./applets/*"

module Sundial
  def self.main
    cmd = File.basename(PROGRAM_NAME)

    if cmd == "sundial" && ARGV.size > 0
      cmd = ARGV.shift
    end

    ctx = Context.new
    exit(dispatch(cmd, ctx))
  end

  def self.dispatch(cmd : String, ctx : Context)
    case cmd
    when "sundial"
      puts "sundial v0.1.0"
      0
    when "echo"
      Applets::Echo.main(ctx)
    else
      STDERR.puts "#{cmd}: applet not found"
      1
    end
  end
end

Sundial.main
