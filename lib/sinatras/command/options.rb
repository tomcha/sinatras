# encoding: utf-8

require 'optparse'

module Sinatras
  class Command
    module Options
      def self.parse!(argv)
        options = {}

        sub_command_parsers = Hash.new do |k, v|
          raise ArgumentError, "'#{v}' is not sinatras sub command"
        end

        sub_command_parsers['new'] = OptionParser.new do |opt|
          opt.on('VAL', 'project name'){|v| options[:name] = v}
        end

        command_parser = OptionParser.new do |opt|
          opt.on_head('-v', '--version', 'show program version') do |v|
            opt.version = Sinatras::VERSION
            puts opt.ver
            exit
          end
        end

        begin
          command_parser.order!(argv)

          options[:command] = argv.shift

          sub_command_parsers[options[:command]].parse!(argv)

        rescue OptionParser::MissingArgument, OptionParser::InvalidOption, ArgumentError => e
          abort e.message
        end

        options
      end
    end
  end
end
