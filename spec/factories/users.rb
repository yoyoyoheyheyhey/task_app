FactoryBot.define do
  factory :user do
    name { 'title User' }
    email { 'test@example.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end
end
