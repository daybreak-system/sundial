module Sundial
  module Applets
    def self.echo(args : Array(String))
      "#{args.join(" ")}\n"
    end
  end
end
