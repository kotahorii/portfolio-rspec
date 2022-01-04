FactoryBot.define do
  factory :user do
    name {"test-user"}
    email {"test@test.jp"}
    id {"123456"}

    trait :invalid do
      name {nil}
    end
  end
end