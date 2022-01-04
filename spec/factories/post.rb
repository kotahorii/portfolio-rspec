FactoryBot.define do
  factory :post do
    id {1}
    user_id {1}
    title {"test"}
    prefecture {'prefecture'}
    city {'city'}
    town {'town'}
    lat {33.59489}
    lng {130.361167}
    
    trait :invalid do
      user_id {nil}
      title {nil}
      prefecture {nil}
      city {nil}
    end
  end
end