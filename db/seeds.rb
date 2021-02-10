%w[
  Ruby
  Python
  Java
  PHP
  VB.NET
].each do |name|
  Label.create(name: name)
end

100.times do |user|
  user = User.create(
    name: "test User#{user + 1}",
    email: "test#{user + 1}@example.com",
    admin: false,
    password: "testtest",
    password_confirmation: "testtest"
  )
  30.times do |task|
    task = Task.create(
      title: "test Title#{task + 1}",
      content: "test Content#{task + 1}",
      end_date: DateTime.current + [*-3..7].sample,
      status: "未着手",
      priority: 0,
      user_id: user.id
    )
    Labelling.create(task_id: task.id, label_id: Label.all.sample.id)
  end
end  