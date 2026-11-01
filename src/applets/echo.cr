module Sundial
  module Applets
    module Echo
      def self.main(ctx : Context)
        ctx.stdout.puts ctx.argv.join(" ")
        ctx.exit(1)
      end
    end
  end
end
