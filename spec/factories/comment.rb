FactoryBot.define do
  factory :comment do
    id {1}
    user_id {1}
    post_id {1}
    comment {'test'}

    trait :invalid do
      user_id {nil}
      post_id {nil}
      comment {nil}
    end
  end
end