FactoryBot.define do
  factory :task do
    sequence(:title){ |n| "test Title#{n}" }
    sequence(:content) { |n| "test Content#{n}" }
  end
end
