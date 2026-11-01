require "option_parser"

module Sundial
  module Applets
    module Wc
      def self.wc(ctx : Context, l : Bool, w : Bool, c : Bool, files : Array(String))
        output = [] of String

        if files.size > 0
          total_lines = 0
          total_words = 0
          total_bytes = 0
          files.each do |file|
            lines = 0
            words = 0
            bytes = File.size(file)
            File.each_line(file) do |line|
              lines += 1
              words += line.split(/\s+/).reject(&.empty?).size
            end

            total_lines += lines
            total_words += words
            total_bytes += bytes

            if l
              output.push(lines.to_s)
            end

            if w
              output.push(words.to_s)
            end

            if c
              output.push(bytes.to_s)
            end

            if files.size > 1
              output.push("#{file}\n")
            else
              output.push(file)
            end
          end

          if files.size > 1
            if l
              output.push(total_lines.to_s)
            end

            if w
              output.push(total_words.to_s)
            end

            if c
              output.push(total_bytes.to_s)
            end

            output.push("total")
          end

          ctx.stdout.puts " " + output.join(" ")
          0
        else
          ctx.stdout.puts "error: unimplemented for now"
          1
        end
      end

      def self.main(ctx : Context)
        lines = false
        words = false
        bytes = false
        files = [] of String

        parser = OptionParser.new do |parser|
          parser.banner = "usage: wc [arguments] [FILEs]"

          parser.on("-l", "--lines", "count number of lines") do
            lines = true
          end

          parser.on("-w", "--words", "count number of words") do
            words = true
          end

          parser.on("-c", "--bytes", "count number of bytes") do
            bytes = true
          end

          parser.unknown_args do |_files|
            files = _files
          end
        end

        parser.parse(ctx.argv)

        if !lines && !words && !bytes
          lines = true
          words = true
          bytes = true
        end

        wc(ctx, lines, words, bytes, files)
      end
    end
  end
end
