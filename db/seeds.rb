100.times do |user|
  User.create!(
    name: "test User#{user + 1}",
    email: "test#{user + 1}@example.com",
    password: "testtest",
    password_confirmation: "testtest"
  )
end

100.times do |task|
  Task.create!(
    title: "test Title#{task + 1}",
    content: "test Content#{task + 1}",
    end_date: "2020-01-01 00:00:00",
    status: "未着手",
    priority: 0,
    user_id: task + 1
  )
end


