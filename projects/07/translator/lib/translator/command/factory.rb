# Encoding: utf-8

require 'translator/commands/add'
require 'translator/commands/and'
require 'translator/commands/equals'
require 'translator/commands/greater_than'
require 'translator/commands/less_than'
require 'translator/commands/negate'
require 'translator/commands/not'
require 'translator/commands/or'
require 'translator/commands/push'
require 'translator/commands/subtract'

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
        tokens = line.split(/\s/)
        case tokens[0]
        when 'add'
          Commands::Add.new
        when 'and'
          Commands::And.new
        when 'eq'
          Commands::Equals.new
        when 'gt'
          Commands::GreaterThan.new
        when 'lt'
          Commands::LessThan.new
        when 'neg'
          Commands::Negate.new
        when 'not'
          Commands::Not.new
        when 'or'
          Commands::Or.new
        when 'push'
          Commands::Push.new(tokens[1], tokens[2])
        when 'sub'
          Commands::Subtract.new
        else
          fail SyntaxError, "VM Syntax Error: \"#{tokens[0]}\" is an unknown command."
        end
      end
    end
  end
end
