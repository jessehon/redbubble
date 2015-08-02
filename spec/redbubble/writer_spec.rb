require 'spec_helper'
require 'redbubble/reader'
require 'redbubble/models/work'
require 'redbubble/exceptions'

describe Redbubble::Writer do
  let(:writer) { Redbubble::Writer.new() }

  describe '#write' do
    before do
      @path = File.join(File.dirname(__FILE__), "..", ".tmp", "write_tests")
      @content = "test content"
      writer.write(content: @content, path: @path)
    end

    it 'created file with content at the path' do
      file_path = File.join(File.join(@path, "index.html"))
      expect(File.exist?(file_path)).to eq(true)
      expect(File.read(file_path)).to eq(@content)
    end
  end
end
