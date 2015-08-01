require 'redbubble/reader'
require 'redbubble/models/make'

module Redbubble
  def self.run(input_file:, template_file:)
    works = Reader.new(input_file: input_file).read
    makes = Redbubble::Models::Make.create_from_works(works: works)

    base_resolver = PathResolver.new()
  end

  def self.generate_index_file(makes:, base_resolver:)
    resolver = base_resolver.resolver(PathSegmant.create_for_index)
    content = IndexView.new(template: file, resolver: resolver, makes: makes).render
    writer.write(content: content, path: resolver.path)
  end

  def self.generate_make_file(makes:, index_resolver)
    makes.each do |make|
      resolver = index_resolver.resolver(PathSegmant.create_for_make(make_name: make.name))
      content = MakeDetailView.new(template: template, resolver: resolver, make: make).render
      writer.write(content: content, path: resolver.path)

  def self.generate_model_file(makes:, index_resolver)
    makes.each do |make|
      make_resolver = index_resolver.resolver(PathSegmant.create_for_make(make_name: make.name))

      make.models.each do |model|
        resolver = make_resolver.resolver(PathSegmant.create_for_model(model_name: model.name))
        content = ModelDetailView.new(template: template, resolver: resolver, model: model).render
        writer.write(content: content, path: resolver.path)
      end
    end
  end
end
