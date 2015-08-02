require 'fileutils'
require 'spec_helper'

describe Redbubble do
  before do
    @output_path = File.join(File.dirname(__FILE__), "..", ".tmp", "tests", "redbubble")
    FileUtils.rm_rf(@output_path)
  end

  describe '#run' do
    let(:input_file) { File.join(File.dirname(__FILE__), "fixtures", "works_valid.xml") }

    context "when valid" do
      before do
        Redbubble.run(input_file: input_file, output_path: @output_path)
      end

      it 'created file for index' do
        file_path = File.join(@output_path, "index.html")
        expect(File.exist?(file_path)).to eq(true)
      end

      it 'created file for index' do
        file_path = File.join(@output_path, "index.html")
        expect(File.exist?(file_path)).to eq(true)
      end

      it 'created file for makes' do
        expected_files = [
          "nikon-corporation/index.html",
          "canon/index.html"
        ]
        expected_files.each do |file|
          file_path = File.join(@output_path, file)
          expect(File.exist?(file_path)).to eq(true)
        end
      end

      it 'created file for models' do
        expected_files = [
          "nikon-corporation/nikon-d80/index.html",
          "canon/canon-eos-20d/index.html"
        ]
        expected_files.each do |file|
          file_path = File.join(@output_path, file)
          expect(File.exist?(file_path)).to eq(true)
        end
      end
    end
  end
end
