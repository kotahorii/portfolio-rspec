FactoryBot.define do
  factory :rate do
    id { 1 }
    user_id { 1 }
    post_id { 1 }
    rate { 3 }
  end
end
