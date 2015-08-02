require 'fileutils'
require 'spec_helper'
require 'redbubble/reader'
require 'redbubble/models/work'
require 'redbubble/exceptions'

describe Redbubble::HtmlGenerator do
  before do
    @output_path = File.join(File.dirname(__FILE__), "..", ".tmp", "tests", "html_generator")
    FileUtils.rm_rf(@output_path)
  end
  let(:makes) { FactoryGirl.build_list(:make, 5) }
  let(:template_file) { Redbubble::DEFAULT_TEMPLATE_FILE }
  let(:resolver) { Redbubble::PathResolver.new(root_path: @output_path) }
  let(:writer) { Redbubble::Writer.new() }
  let(:generator) do
    Redbubble::HtmlGenerator.new(
      makes: makes,
      template_file: template_file,
      resolver: resolver,
      writer: writer
    )
  end

  describe '#generate' do
    let(:generated_files) { generator.generate }

    it 'returned generated files' do
      generated_files.each do |file_path|
        expect(File.exist?(file_path)).to eq(true)
      end
    end
  end
end
