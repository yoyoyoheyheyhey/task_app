100.times do |tasks|
  Task.create!(
    title: "test Title#{tasks + 1}",
    content: "test Content#{tasks + 1}",
    end_date: "2020-01-01 00:00:00",
    status: "未着手",
    priority: 0
  )
end