100.times do |user|
  @user = User.create!(
    name: "test User#{user + 1}",
    email: "test#{user + 1}@example.com",
    admin: false,
    password: "testtest",
    password_confirmation: "testtest"
  )
  30.times do |task|
    Task.create!(
    title: "test Title#{task + 1}",
    content: "test Content#{task + 1}",
    end_date: "2020-01-01 00:00:00",
    status: "未着手",
    priority: 0,
    user_id: @user.id
    )
  end
end  
@user = User.create!(
  name: "test User999",
  email: "test999@example.com",
  admin: true,
  password: "testtest",
  password_confirmation: "testtest"
)