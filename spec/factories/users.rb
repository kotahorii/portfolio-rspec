FactoryBot.define do
  factory :user do
    id {1}
    name {"raspec-user"}
    email {"rspec@test.jp"}
    password {'password'}
    prefecture {1}
    introduction {'testtesttest'}

    trait :invalid do
      name {nil}
    end
  end
end