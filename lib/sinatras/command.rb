# encoding: utf-8

module Sinatras
  #コマンドライン処理を行うクラス
  # @auther tomcha_
  class Command

    def execute
      options = Options.parse!(@argv)
      sub_command = options.delete(:command)

      tasks = case sub_command
              when 'new'
                new(options)
              end
    end

    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv = argv
    end

    def new(options)
      appname = options[:appname]
      if options[:appname] !~ /^[a-z_]+[a-zA-Z0-9_]*$/
        puts 'appname format is (a-z or _ ) + (alphabet,0-9, and _)'
        exit
      end
      if (File.directory?(appname))
        puts 'appname same name of the directory exist'
        exit
      end
      Dir.mkdir(appname, 0755)
      puts "make directory ./" + appname + "/"
      Dir.mkdir(appname + "/app", 0755)
      puts "make directory ./" + appname + "/app/"
      Dir.mkdir(appname + "/app/views", 0755)
      puts "make directory ./" + appname + "/app/views/"
      Dir.mkdir(appname + "/spec",  0755)
      puts "make directory ./" + appname + "/spec/"
      Dir.mkdir(appname + "/public", 0755)
      puts "make directory ./" + appname + "/public/"
      Dir.mkdir(appname + "/config", 0755)
      puts "make directory ./" + appname + "/config/"

      File.open("./" + appname + "/Gemfile","w") do |file|
        file.print <<__EOS__
source "https://rubygems.org"
gem 'sinatra'
gem 'haml'
gem 'rspec'
__EOS__
      end
      puts "make file ./" + appname + "/Gemfile"

      File.open("./" + appname + "/config.ru","w") do |file|
        classname = appname.split("",2)
        file.puts "require './app/" + appname + "'"
        file.puts "run " + classname[0].upcase + classname[1]
      end
      puts "make file ./" + appname + "/config.ru"

      File.open("./" + appname + "/app/" + appname + ".rb","w") do |file|
        classname = appname.split("",2)
        file.print <<__EOS__
require 'sinatra/base'
require 'haml'

__EOS__
        file.puts "class " + classname[0].upcase + classname[1] + "< Sinatra::Base"
        file.print <<__EOS__
  get '/' do
    haml :index
  end
end
__EOS__
      end
      puts "make file ./" + appname + "/app/" + appname + ".rb"

      File.open("./" + appname + "/app/views/layout.haml","w") do |file|
        file.print <<__EOS__
!!!
%html{lang: 'ja'}
  %head
    %meta{charset: 'utf-8'}
    %title
      hello,sinatras
  %body
    %div
      =yield
__EOS__
      end
      puts "make file ./" + appname + "/app/views/layout.haml"

      File.open("./" + appname + "/app/views/index.haml","w") do |file|
        file.print <<__EOS__
%h1
  Hello,Sinatras
%p
  powerd by Sinatra
__EOS__
      end
      puts "make file ./" + appname + "/app/views/index.haml"

      File.chmod(0644, "./" + appname + "/Gemfile")
      puts "change permission file ./" + appname + "/Gemfile"
      File.chmod(0644, "./" + appname + "/config.ru")
      puts "change permission file ./" + appname + "/config.ru"
      File.chmod(0644, "./" + appname + "/app/" + appname+ ".rb")
      puts "change permission file ./" + appname + "/app/" + appname + ".rb"
      File.chmod(0644, "./" + appname + "/app/views/layout.haml")
      puts "change permission file ./" + appname + "/app/views/layout.haml"
      File.chmod(0644, "./" + appname + "/app/views/index.haml")
      puts "change permission file ./" + appname + "/app/views/index.haml"

      Dir.chdir("./#{appname}") do
        init = `git init`
        puts "git init is success." if init
        add = `git add -A`
        puts "git add -A is success." if add
        comm = `git commit -m 'first commit'`
        puts "git commit -m 'first commit' is success." if comm
      end
      1
    end
  end
end
