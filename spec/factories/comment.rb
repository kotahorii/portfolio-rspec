FactoryBot.define do
  factory :comment do
    id { 1 }
    user_id { 1 }
    post_id { 1 }
    comment { 'test' }
  end
end