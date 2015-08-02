require 'fileutils'
require 'spec_helper'
require 'redbubble/reader'
require 'redbubble/models/work'
require 'redbubble/exceptions'

describe Redbubble::Writer do
  before do
    @output_path = File.join(File.dirname(__FILE__), "..", ".tmp", "tests", "writer")
    FileUtils.rm_rf(@output_path)
  end
  let(:writer) { Redbubble::Writer.new() }

  describe '#write' do
    before do
      @content = "test content"
      @written_file = writer.write(content: @content, path: @output_path)
      @file_path = File.join(File.join(@output_path, "index.html"))
    end

    it 'created file with content at the path' do
      expect(File.exist?(@file_path)).to eq(true)
      expect(File.read(@file_path)).to eq(@content)
    end

    it 'returns created file' do
      expect(@written_file).to eq(@file_path)
    end
  end
end
