FactoryBot.define do
  factory :friendship do
    confirmed { false }
    association :invitor, factory: :user
    association :invitee, factory: :user
  end
end
