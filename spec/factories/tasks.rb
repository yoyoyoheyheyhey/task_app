FactoryBot.define do
  factory :task do
    title { "test Title" }
    content { "test Content" }
    end_date { "2020-01-01" }
    status { "未着手" }
    priority { 0 }
  end
end
