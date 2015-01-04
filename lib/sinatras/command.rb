# encoding: utf-8

module Sinatras
  #コマンドライン処理を行うクラス
  # @auther tomcha_
  class Command

    def execute
      options = Options.parse!(@argv)
    end

    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv = argv
    end

  end
end
