FactoryGirl.define do
  factory :blog do
    title { Faker::Lorem.sentence(3) }
    content { Faker::Lorem.paragraphs }
  end
end
