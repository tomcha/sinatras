# encoding: utf-8

require 'optparse'

module Sinatras
  class Command
    module Options
      def self.parse!(argv)
        options = {}

        sub_command_parsers = create_sub_command_parsers(options)
        command_parser = create_command_parser


        begin
          command_parser.order!(argv)

          options[:command] = argv.shift

          sub_command_parsers[options[:command]].parse!(argv)

          if options[:command] == 'new'
            raise ArgumentError, "#{options[:command]} Appname not found." if argv.empty?
            options[:appname] = String(argv.first)
          end

        rescue OptionParser::MissingArgument, OptionParser::InvalidOption, ArgumentError => e
          abort e.message
        end

        options
      end

      def self.create_sub_command_parsers(options)
        sub_command_parsers = Hash.new do |k, v|
          raise ArgumentError, "'#{v}' is not sinatras sub command"
        end

        sub_command_parsers['new'] = OptionParser.new do |opt|
          opt.banner = 'Usage: new <args>'
          opt.on_tail('-h', '--help', 'Show this message'){|v| help_sub_command(opt)}
        end

        sub_command_parsers
      end

      def self.help_sub_command(parser)
        puts parser.help
        exit
      end

      def self.create_command_parser
        command_parser = OptionParser.new do |opt|
          sub_command_help = [
            {name: 'new Appname', summary: 'create new project scalton'},
          ]
          opt.banner = "Usage: #{opt.program_name} [-h|--help][-v|--version] <command>[<args>]"
          opt.separator ''
          opt.separator "#{opt.program_name} Available Commands:"
          sub_command_help.each do |command|
            opt.separator [opt.summary_indent, command[:name].ljust(40), command[:summary]].join (' ')
          end

          opt.on_head('-h', '--help', ) do |v|
            puts opt.help
            exit
          end

          opt.on_head('-v', '--version', 'show program version') do |v|
            opt.version = Sinatras::VERSION
            puts opt.ver
            exit
          end
        end
      end
    end
  end
  private_class_method :create_sub_command_parsers, :create_command_parser, :help_sub_command
end
