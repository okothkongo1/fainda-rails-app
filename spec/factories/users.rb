FactoryBot.define do
  factory :user do
    first_name { "Jane" }
    last_name {"Doe"}
    email { "user@random.com" }
    password {'Password@123'}
    password_confirmation {'Password@123'}
  end
end
