require 'spec_helper'
require 'erb'
require 'redbubble/views/index_view'
require 'redbubble/path_resolver'
require 'redbubble/path_segment'

describe Redbubble::Views::IndexView do
  let(:make) { FactoryGirl.build(:make) }
  let(:template) { ERB.new(File.read(Redbubble::DEFAULT_TEMPLATE_FILE)) }
  let(:resolver) { Redbubble::PathResolver.new(segments: [Redbubble::PathSegment.create_for_make(make_name: make.name)]) }

  context 'when valid' do
    let(:view) { Redbubble::Views::MakeDetailView.new(template: template, resolver: resolver, make: make) }

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

      it 'has item links html' do
        view.item_links.each do |link|
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
