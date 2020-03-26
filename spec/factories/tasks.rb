FactoryBot.define do
  factory :task do
    # sequence(:title){ |n| "test Title#{n}" }
    # sequence(:content) { |n| "test Content#{n}" }
    title { "test Title" }
    content { "test Content" }
    end_date {"2020-12-31 00:00:00"}
    status {"完了"}
    priority { 0 }
  end
end
