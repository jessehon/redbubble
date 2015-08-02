require 'spec_helper'
require 'redbubble/path_resolver'
require 'redbubble/path_segment'

describe Redbubble::PathResolver do
  context 'when empty' do
    let(:resolver) { Redbubble::PathResolver.new() }

    it 'has empty title' do
      expect(resolver.title).to eq("")
    end

    it 'has root path' do
      expect(resolver.path).to eq("/")
    end

    it 'has no parent' do
      expect(resolver.up(1)).to eq(nil)
    end
  end

  context 'with 1 segment' do
    let(:segments) { [FactoryGirl.build(:path_segment)] }
    let(:resolver) { Redbubble::PathResolver.new(segments: segments) }

    it 'has title' do
      expect(resolver.title).to eq(segments[0].title)
    end

    it 'has path' do
      expect(resolver.path).to eq("/#{segments[0].path}")
    end

    it 'has no parent' do
      expect(resolver.up(1)).to eq(nil)
    end
  end

  context 'with 3 segments' do
    let(:segments) { FactoryGirl.build_list(:path_segment, 3) }
    let(:resolver) { Redbubble::PathResolver.new(segments: segments) }

    it 'has last segment title' do
      expect(resolver.title).to eq(segments.last.title)
    end

    it 'has combined segment paths' do
      expected = File.join("", segments.map { |s| s.path })
      expect(resolver.path).to eq(expected)
    end

    it 'has dropped last segment' do
      expected = [segments[0], segments[1]]
      expect(resolver.up(1).segments).to eq(expected)
    end
  end

  describe '#resolve' do
    let(:segments) { FactoryGirl.build_list(:path_segment, 3) }
    let(:resolver) { Redbubble::PathResolver.new(segments: segments) }
    let(:extra_segment) { FactoryGirl.build(:path_segment) }

    it 'has added 1 segment' do
      new_resolver = resolver.resolver(extra_segment)
      expected = segments + [extra_segment]
      expect(new_resolver.segments).to eq(expected)
    end
  end
end
