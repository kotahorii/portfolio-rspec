FactoryBot.define do
  factory :label do
    id {1}
    user_id {1}
    post_id {1}
    name {'test'}

    trait :invalid do
      user_id {nil}
      post_id {nil}
      name {nil}
    end
  end
end