# Encoding: utf-8

require 'translator/commands/add'
require 'translator/commands/and'
require 'translator/commands/equals'
require 'translator/commands/greater_than'
require 'translator/commands/less_than'
require 'translator/commands/negate'
require 'translator/commands/not'
require 'translator/commands/or'
require 'translator/commands/pop'
require 'translator/commands/push'
require 'translator/commands/subtract'

module Translator
  module Command
    class Factory
      def build(line)
        fail ArgumentError, 'Invalid line provided.' unless line.valid?
        build_command(line)
      end

      private

      def build_command(line)
        tokens = line.instruction.split(/\s/)
        case tokens[0]
        when 'add'
          Commands::Add.new
        when 'and'
          Commands::And.new
        when 'eq'
          Commands::Equals.new(line.id)
        when 'gt'
          Commands::GreaterThan.new(line.id)
        when 'lt'
          Commands::LessThan.new(line.id)
        when 'neg'
          Commands::Negate.new
        when 'not'
          Commands::Not.new
        when 'or'
          Commands::Or.new
        when 'pop'
          Commands::Pop.new(tokens[1], tokens[2])
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
