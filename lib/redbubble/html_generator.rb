require 'erb'
require 'redbubble/path_segment'
require 'redbubble/views/index_view'
require 'redbubble/views/make_detail_view'
require 'redbubble/views/model_detail_view'

module Redbubble
  class HtmlGenerator
    def initialize(makes:, template_file:, resolver:, writer:)
      @makes = makes
      @template = ERB.new(File.read(template_file))
      @base_resolver = resolver
      @index_resolver = @base_resolver.resolver(PathSegment.create_for_index)
      @writer = writer
    end

    def generate
      generate_index_file
      generate_make_files
      generate_model_files
    end

    def generate_index_file
      content = Views::IndexView.new(
          template: @template,
          resolver: @index_resolver,
          makes: @makes
        ).render
      @writer.write(content: content, path: @index_resolver.path)
    end

    def generate_make_files
      @makes.each do |make|
        resolver = @index_resolver.resolver(PathSegment.create_for_make(make_name: make.name))
        content = Views::MakeDetailView.new(
            template: @template,
            resolver: resolver,
            make: make
          ).render
        @writer.write(content: content, path: resolver.path)
      end
    end

    def generate_model_files
      @makes.each do |make|
        make_resolver = @index_resolver.resolver(PathSegment.create_for_make(make_name: make.name))

        make.models.each do |model|
          resolver = make_resolver.resolver(PathSegment.create_for_model(model_name: model.name))
          content = Views::ModelDetailView.new(
              template: @template,
              resolver: resolver,
              model: model
            ).render
          @writer.write(content: content, path: resolver.path)
        end
      end
    end
  end
end
