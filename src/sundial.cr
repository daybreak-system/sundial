require "./context"
require "./applets/*"

module Sundial
  def self.main
    invocation = File.basename(PROGRAM_NAME)

    if invocation != "sundial"
      command = invocation
    elsif !ARGV.empty?
      command = ARGV[0]
      ARGV.shift
    end

    ctx = Context.new
    dispatch(command, ctx)
  end

  def self.dispatch(command : String | Nil, ctx : Context)
    case command
    when nil
      puts "sundial v0.1.0"
    when "echo"
      Applets::Echo.main(ctx)
    else
      abort("error: #{command} applet not found")
    end
  end
end

Sundial.main
