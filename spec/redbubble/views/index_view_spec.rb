require 'spec_helper'
require 'erb'
require 'redbubble/views/index_view'
require 'redbubble/path_resolver'
require 'redbubble/path_segment'

describe Redbubble::Views::IndexView do
  let(:makes) { FactoryGirl.build_list(:make, 5) }
  let(:template) { ERB.new(File.read(Redbubble::TEMPLATE_FILE)) }
  let(:resolver) { Redbubble::PathResolver.new(segments: [Redbubble::PathSegment.create_for_index]) }

  context 'when valid' do
    let(:view) { Redbubble::Views::IndexView.new(template: template, resolver: resolver, makes: makes) }

    describe '#back_links' do
      it 'has none' do
        expect(view.back_links).to eq([])
      end
    end

    describe '#render' do
      let(:result) { view.render }

      it 'has title html' do
        expected = "<title>#{resolver.title}</title>"
        expect(result).to include(expected)
      end

      it 'has links html' do
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
