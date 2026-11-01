require "./context"
require "./applets/*"

module Sundial
  def self.main
    cmd = File.basename(PROGRAM_NAME)

    if cmd == "sundial" && ARGV.size > 0
      cmd = ARGV.shift
    end

    ctx = Context.new(STDIN, STDOUT, STDERR, ARGV)
    exit(dispatch(cmd, ctx))
  end

  def self.dispatch(cmd : String, ctx : Context)
    case cmd
    when "sundial"
      ctx.stdout.puts "sundial v0.1.0"
      0
    when "cat"
      Applets::Cat.main(ctx)
    when "echo"
      Applets::Echo.main(ctx)
    when "wc"
      Applets::Wc.main(ctx)
    else
      ctx.stderr.puts "#{cmd}: applet not found"
      1
    end
  end
end

Sundial.main
