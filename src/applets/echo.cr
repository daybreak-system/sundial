module Sundial
  module Applets
    module Echo
      def self.main(ctx : Context)
        ctx.stdout.puts ctx.argv.join(" ")
        0
      end
    end
  end
end
