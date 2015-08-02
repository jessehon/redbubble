require 'spec_helper'
require 'redbubble/path_segment'

describe Redbubble::PathSegment do
  describe '#create_for_index' do
    let(:segment) { Redbubble::PathSegment.create_for_index }

    it 'has index title' do
      expect(segment.title).to eq("Redbubble")
    end

    it 'has index path' do
      expect(segment.path).to eq("")
    end
  end

  describe '#create_for_make' do
    let(:make) { FactoryGirl.build(:make, name: "Make 1") }
    let(:segment) { Redbubble::PathSegment.create_for_make(make_name: make.name) }

    it 'has make title' do
      expect(segment.title).to eq("Make 1")
    end

    it 'has make path' do
      expect(segment.path).to eq("make-1")
    end
  end

  describe '#create_for_model' do
    let(:model) { FactoryGirl.build(:model, name: "Model 1") }
    let(:segment) { Redbubble::PathSegment.create_for_model(model_name: model.name) }

    it 'has model title' do
      expect(segment.title).to eq("Model 1")
    end

    it 'has model path' do
      expect(segment.path).to eq("model-1")
    end
  end
end
