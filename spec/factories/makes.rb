require 'redbubble/models/make'

FactoryGirl.define do
  factory :make, class: Redbubble::Models::Make do
    name { Faker::Company.name }

    initialize_with { new(name: name, models: build_list(:model, 3, make_name: name)) }
  end
end
