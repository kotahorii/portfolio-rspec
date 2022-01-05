FactoryBot.define do
  factory :user do
    id {1}
    name {"rspec-user"}
    email {"rspec@test.jp"}
    password {'password'}
    prefecture {14}
    introduction {'testtesttest'}
  end
end