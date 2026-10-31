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

    dispatch(command, ARGV)
  end

  def self.dispatch(command : String | Nil, args : Array(String))
    case command
    when nil
      puts "sundial v0.1.0"
    when "cat"
      print Applets.cat(args)
    when "echo"
      print Applets.echo(args)
    else
      abort("error: #{command} applet not found")
    end
  end
end

Sundial.main
