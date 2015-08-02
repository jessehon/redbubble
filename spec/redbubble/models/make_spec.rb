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

  describe '#create_from_works' do
    let(:expected_makes) { FactoryGirl.build_list(:make, 3) }
    let(:expected_models) do
      (expected_makes.map { |make| make.models }).flatten
    end
    let(:works) do
      (expected_models.map { |model| model.works }).flatten
    end
    let(:makes) { Redbubble::Models::Make.create_from_works(works: works) }

    it 'created makes with models and works' do
      expected_makes_a = expected_makes.map { |make| make.models.map {|model| model.works} }
      makes_a = makes.map { |make| make.models.map {|model| model.works} }
      expect(makes_a).to match_array(expected_makes_a)
    end
  end
end
