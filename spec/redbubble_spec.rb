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

      it 'created file' do
        file_path = File.join(@output_path, "index.html")
        expect(File.exist?(file_path)).to eq(true)
      end

      describe "index html" do
        let(:result) { File.read(File.join(@output_path, "index.html")) }

        it 'has title' do
          expected = "<title>Redbubble</title>"
          expect(result).to include(expected)
        end

        it 'has links' do
          expected_links = [
            {href: "nikon-corporation/index.html", name: "NIKON CORPORATION"},
            {href: "canon/index.html", name: "Canon"},
          ]
          expected_links.each do |link|
            link_path = File.join(@output_path, link[:href])
            expected_content = "<a href=\"#{link_path}\">#{link[:name]}</a>"
            expect(result).to include(expected_content)
          end
        end

        it 'has thumbnails' do
          expected_thumbail_urls = [
            "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg",
            "http://ih1.redbubble.net/work.2041.1.flat,135x135,075,f.jpg"
          ]
          expected_thumbail_urls.each do |url|
            expected = "<img src=\"#{url}\">"
            expect(result).to include(expected)
          end
        end
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
