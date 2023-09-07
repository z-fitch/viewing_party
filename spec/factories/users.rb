# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.email }
    password { "test123" }
    password_confirmation { "test123" }
  end
end
