require 'spec_helper'
require 'erb'
require 'redbubble/exceptions'

describe Redbubble::Models::Work do
  context 'when valid' do
    let(:work) do
      Redbubble::Models::Work.new(
          id: 1,
          model_name: "NIKON D80",
          make_name: "NIKON CORPORATION",
          thumbnail_url: "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg",
        )
    end

    it 'has id' do
      expect(work.id).to eq(1)
    end

    it 'has model name' do
      expect(work.model_name).to eq("NIKON D80")
    end

    it 'has make name' do
      expect(work.make_name).to eq("NIKON CORPORATION")
    end

    it 'has thumbnail url' do
      expect(work.thumbnail_url).to eq("http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg")
    end
  end

  context 'when id is missing' do
    let(:work) do
      Redbubble::Models::Work.new(
          model_name: "NIKON D80",
          make_name: "NIKON CORPORATION",
          thumbnail_url: "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg",
        )
    end

    it 'raises exception' do
      expect{work}.to raise_error(ArgumentError)
    end
  end

  context 'when id is not integer' do
    let(:work) do
      Redbubble::Models::Work.new(
          id: "1",
          model_name: "NIKON D80",
          make_name: "NIKON CORPORATION",
          thumbnail_url: "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg",
        )
    end

    it 'raises exception' do
      expect{work}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end

  context 'when model name is empty' do
    let(:work) do
      Redbubble::Models::Work.new(
          id: "1",
          model_name: "",
          make_name: "NIKON CORPORATION",
          thumbnail_url: "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg",
        )
    end

    it 'raises exception' do
      expect{work}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end

  context 'when thumbnail url is empty' do
    let(:work) do
      Redbubble::Models::Work.new(
          id: 1,
          model_name: "NIKON D80",
          make_name: "NIKON CORPORATION",
          thumbnail_url: "",
        )
    end

    it 'raises exception' do
      expect{work}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end
end
