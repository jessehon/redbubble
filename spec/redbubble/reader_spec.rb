require 'spec_helper'
require 'redbubble/reader'
require 'redbubble/models/work'
require 'redbubble/exceptions'

describe Redbubble::Reader do
  context 'when valid' do
    let(:input_file) { File.join(File.dirname(__FILE__), "..", "fixtures", "works_valid.xml") }
    let(:reader) { Redbubble::Reader.new(input_file: input_file) }

    describe '#read' do
      let(:works) { reader.read }

      it 'returns works' do
        expect(works[0].id).to eq(1)
        expect(works[0].make_name).to eq("NIKON CORPORATION")
        expect(works[0].model_name).to eq("NIKON D80")
        expect(works[0].thumbnail_url).to eq("http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg")

        expect(works[1].id).to eq(2)
        expect(works[1].make_name).to eq("Canon")
        expect(works[1].model_name).to eq("Canon EOS 20D")
        expect(works[1].thumbnail_url).to eq("http://ih1.redbubble.net/work.2041.1.flat,135x135,075,f.jpg")
      end
    end
  end

  context 'when input is missing urls' do
    let(:input_file) { File.join(File.dirname(__FILE__), "..", "fixtures", "works_missing_urls.xml") }
    let(:reader) { Redbubble::Reader.new(input_file: input_file) }

    describe '#read' do
      let(:works) { reader.read }

      it 'raises exception' do
        expect{works}.to raise_error(Redbubble::Exceptions::ValidationError)
      end
    end
  end

  context 'when input is empty' do
    let(:input_file) { File.join(File.dirname(__FILE__), "..", "fixtures", "works_empty.xml") }
    let(:reader) { Redbubble::Reader.new(input_file: input_file) }

    describe '#read' do
      let(:works) { reader.read }

      it 'returns empty' do
        expect(works).to eq([])
      end
    end
  end
end
