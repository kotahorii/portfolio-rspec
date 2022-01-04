FactoryBot.define do
  factory :todo do
    id {1}
    user_id {1}
    post_id {1}

    trait :invalid do
      user_id {nil}
      post_id {nil}
    end
  end
end