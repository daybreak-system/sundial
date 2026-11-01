module Sundial
  module Applets
    module Wc
      def self.main(ctx : Context)
        ctx.argv.each do |file|
          lines = 0
          words = 0
          bytes = File.size(file)
          File.each_line(file) do |line|
            lines += 1
            words += line.split(/\s+/).reject(&.empty?).size
          end

          ctx.stdout.puts "#{lines} #{words} #{bytes} #{file}"
        end
        0
      end
    end
  end
end
