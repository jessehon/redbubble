require 'spec_helper'
require 'erb'
require 'redbubble/exceptions'

describe Redbubble::Models::Make do
  let(:models) { FactoryGirl.build_list(:model, 5) }

  context 'when valid' do
    let(:make) do
      Redbubble::Models::Make.new(
          name: "NIKON CORPORATION",
          models: models,
        )
    end

    it 'has name' do
      expect(make.name).to eq("NIKON CORPORATION")
    end

    it 'has models' do
      expect(make.models).to eq(models)
    end
  end

  context 'when name is missing' do
    let(:make) do
      Redbubble::Models::Make.new(
          models: models,
        )
    end

    it 'raises exception' do
      expect{make}.to raise_error(ArgumentError)
    end
  end

  context 'when name is not string' do
    let(:make) do
      Redbubble::Models::Make.new(
          name: 13,
          models: models,
        )
    end

    it 'raises exception' do
      expect{make}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end

  context 'when name is empty' do
    let(:make) do
      Redbubble::Models::Make.new(
          name: "",
          models: models,
        )
    end

    it 'raises exception' do
      expect{make}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end

  context 'when models is not array' do
    let(:make) do
      Redbubble::Models::Make.new(
          name: "NIKON CORPORATION",
          models: "NIKON D80",
        )
    end

    it 'raises exception' do
      expect{make}.to raise_error(Redbubble::Exceptions::ValidationError)
    end
  end
end
