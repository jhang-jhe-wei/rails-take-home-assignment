# frozen_string_literal: true

FactoryBot.define do
  factory :tracking_list do
    user factory: :user
    sequence(:name) { |n| "list#{n}" }
  end
end
