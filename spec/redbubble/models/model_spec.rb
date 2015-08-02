require 'spec_helper'
require 'erb'
require 'redbubble/exceptions'

describe Redbubble::Models::Model do
  let(:works) { FactoryGirl.build_list(:work, 5) }

  context 'when valid' do
    let(:model) do
      Redbubble::Models::Model.new(
          name: "NIKON D80",
          make_name: "NIKON CORPORATION",
          works: works,
        )
    end

    it 'has name' do
      expect(model.name).to eq("NIKON D80")
    end

    it 'has make name' do
      expect(model.make_name).to eq("NIKON CORPORATION")
    end

    it 'has works' do
      expect(model.works).to eq(works)
    end
  end

  context 'when name is missing' do
    let(:model) do
      Redbubble::Models::Model.new(
          make_name: "NIKON CORPORATION",
          works: works,
        )
    end

    it 'raises exception' do
      expect{model}.to raise_error(ArgumentError)
    end
  end

  context 'when name is not string' do
    let(:model) do
      Redbubble::Models::Model.new(
          name: 13,
          make_name: "NIKON CORPORATION",
          works: works,
        )
    end

    it 'raises exception' do
      expect{model}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end

  context 'when name is empty' do
    let(:model) do
      Redbubble::Models::Model.new(
          name: "",
          make_name: "NIKON CORPORATION",
          works: works,
        )
    end

    it 'raises exception' do
      expect{model}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end

  context 'when models is not array' do
    let(:model) do
      Redbubble::Models::Model.new(
          name: "NIKON D80",
          make_name: "NIKON CORPORATION",
          works: 123,
        )
    end

    it 'raises exception' do
      expect{model}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end
end
