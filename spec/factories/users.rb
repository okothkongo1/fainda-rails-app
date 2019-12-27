# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Jane' }
    last_name { 'Doe' }
    password { 'Stronger*than123Usual' }
    password_confirmation { 'Stronger*than123Usual' }
    email { 'janedoe@gmail.com' }
  end
end
