require 'spec_helper'
require 'fileutils'

describe Sinatras do
  it 'should have a version number' do
    expect(Sinatras::VERSION).not_to be nil
  end
  
  describe Sinatras::Command do
    describe '#execute' do
    end
    describe 'new' do
    end
    describe '.run' do
      before do
        FileUtils.rm_rf("foo") if File.exists?("foo")
      end

      after(:all) do
        FileUtils.rm_rf("foo") if File.exists?("foo")
      end

      let(:command){ Sinatras::Command.run(params) }
      subject{ command }
      
      context '第1引数にnewが渡された場合' do
        context '第1引数のみ渡された場合' do
          let(:params){ ['new'] }
          it '' do
            expect{command}.to raise_error SystemExit
          end
        end
        context '第1引数と第2引数が渡された場合' do
          let(:params){ ['new', 'foo'] }
          it { is_expected.to eq 1}
        end
      end

      context '第1引数にnewが渡されなかった場合' do
        context '第1引数のみ渡された場合' do
          let(:params){ ['mew'] }
#          it { is_expected.not_to eq 1}
          it '' do
            expect{command}.to raise_error SystemExit
          end
        end
        context '第1引数と第2引数が渡された場合' do
          let(:params){ ['mew', 'hoge'] }
#          it { is_expected.not_to eq 1}
          it '' do
            expect{command}.to raise_error SystemExit
          end
        end
      end
    end
  end
end

__END__

Class Sinatras
  exexute
  self.run(argv)
  initialize(argv)
  new(options)

  self.parse!(argv)
  self.create_sub_command_parsers(option)
  self.help_sub_command(parser)
  self.create_command_parser
