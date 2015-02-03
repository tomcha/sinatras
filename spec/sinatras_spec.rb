require 'spec_helper'
require 'fileutils'

describe Sinatras do
  it 'should have a version number' do
    expect(Sinatras::VERSION).not_to be nil
  end
  
  describe Sinatras::Command do

    describe '.run' do
      before do
        FileUtils.rm_rf("foo") if File.exists?("foo")
      end

      after(:all) do
        FileUtils.rm_rf("foo") if File.exists?("foo")
      end

      let(:command){ Sinatras::Command.run(params) }
      subject{ command }
      
      context 'If new is passed as the first argument' do #第1引数にnewが渡された場合
        context 'If passed only the first argument' do #第1引数のみ渡された場合
          let(:params){ ['new'] }
          it '' do
            expect{command}.to raise_error SystemExit
          end
        end
        context 'If the first argument and the second argument is passed' do #第1引数と第2引数が渡された場合
          let(:params){ ['new', 'foo'] }
          it { is_expected.to eq 1}
        end
      end

      context 'If the new has not been passed to the first argument' do #第1引数にnewが渡されなかった場合
        context 'If passed only the first argument' do #第1引数のみ渡された場合
          let(:params){ ['mew'] }
#          it { is_expected.not_to eq 1}
          it '' do
            expect{command}.to raise_error SystemExit
          end
        end
        context 'If the first argument and the second argument is passed' do #第1引数と第2引数が渡された場合
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
