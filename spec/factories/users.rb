FactoryBot.define do
  password = 'password'
  name = 'john doe'
  factory :user do
    name { Faker::Name.name[1..20] }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
