# Encoding: utf-8

require 'translator/commands/push'

module Translator
  module Command
    class Factory
      def build(line)
        cleaned = clean(line)
        return nil if cleaned == ''
        build_command(cleaned)
      end

      private

      def clean(line)
        line.gsub(%r(//.+), '').strip
      end

      def build_command(line)
        puts line.inspect
        tokens = line.split(/\s/)
        case tokens[0]
        when 'push'
          Commands::Push.new(tokens[1], tokens[2])
        when 'add'
          Commands::Add.new
        else
          fail SyntaxError, "VM Syntax Error: \"#{tokens[0]}\" is an unknown command."
        end
      end
    end
  end
end
