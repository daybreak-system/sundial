module Sundial
  module Applets
    def self.cat(args : Array(String))
      content = ""
      args.each do |arg|
        if File.exists?(arg)
          content += File.read(arg)
        else
          abort("error: #{arg} does not exist")
        end
      end
      content
    end
  end
end
