require 'redbubble/path_segment'

FactoryGirl.define do
  factory :path_segment, class: Redbubble::PathSegment do
    sequence(:title) { |n| "Path #{n}" }

    initialize_with { new(title: title) }
  end
end
