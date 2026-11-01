module Sundial
  module Applets
    module Cat
      def self.main(ctx : Context)
        if ctx.argv.size > 0
          ctx.argv.each do |file|
            if File.exists?(file)
              ctx.stdout.print File.read(file)
            else
              ctx.stderr.puts "can't open #{file}"
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
