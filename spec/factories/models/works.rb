require 'redbubble/models/work'

FactoryGirl.define do
  factory :work, class: Redbubble::Models::Work do
    id { Faker::Number.between(1, 1000) }
    model_name { Faker::Commerce.product_name }
    make_name { Faker::Company.name }
    thumbnail_url { Faker::Avatar.image }

    initialize_with { new(attributes) }
  end
end
