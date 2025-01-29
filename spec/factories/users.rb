FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    password_digest { Faker::Internet.password }
    bio { Faker::Lorem.paragraph }
  end
end
