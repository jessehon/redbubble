require 'redbubble/models/model'

FactoryGirl.define do
  factory :model, class: Redbubble::Models::Model do
    name { Faker::Commerce.product_name }
    make_name { Faker::Company.name }

    initialize_with { new(name: name, make_name: make_name, works: build_list(:work, 5, model_name: name, make_name: make_name)) }
  end
end
