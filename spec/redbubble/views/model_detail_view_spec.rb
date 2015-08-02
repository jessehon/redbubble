require 'spec_helper'
require 'erb'
require 'redbubble/views/index_view'
require 'redbubble/path_resolver'
require 'redbubble/path_segment'

describe Redbubble::Views::IndexView do
  let(:model) { FactoryGirl.build(:model) }
  let(:template) { ERB.new(File.read(Redbubble::DEFAULT_TEMPLATE_FILE)) }
  let(:resolver) { Redbubble::PathResolver.new(segments: [Redbubble::PathSegment.create_for_model(model_name: model.name)]) }

  context 'when valid' do
    let(:view) { Redbubble::Views::ModelDetailView.new(template: template, resolver: resolver, model: model) }

    it 'has no item links' do
      expect(view.item_links).to eq([])
    end

    describe '#render' do
      let(:result) { view.render }

      it 'has title html' do
        expected = "<title>#{resolver.title}</title>"
        expect(result).to include(expected)
      end

      it 'has back links html' do
        view.back_links.each do |link|
          expected = "<a href=\"#{link.href}\">#{link.name}</a>"
          expect(result).to include(expected)
        end
      end

      it 'has thumbnails html' do
        view.thumbnails.each do |thumbnail|
          expected = "<img src=\"#{thumbnail.src}\">"
          expect(result).to include(expected)
        end
      end
    end
  end
end
