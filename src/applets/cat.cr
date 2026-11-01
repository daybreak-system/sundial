module Sundial
  module Applets
    module Cat
      def self.main(ctx : Context)
        if ctx.argv.size > 0
          ctx.argv.each do |arg|
            if File.exists?(arg)
              File.open(arg) do |file|
                IO.copy(file, ctx.stdout)
              end
            else
              ctx.stderr.puts "can't open #{arg}"
              1
            end
          end
          0
        else
          IO.copy(ctx.stdin, ctx.stdout)
          0
        end
      end
    end
  end
end
