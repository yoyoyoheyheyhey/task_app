require 'rails_helper'

RSpec.describe Task, type: :model do
  it "titleが空ならバリデーションが通らない" do
    task = FactoryBot.build(:task, title: nil)
    task.valid?
    expect(task.errors.full_messages).to include "タイトルを入力してください"
  end

  it "contentが空ならバリデーションが通らない" do
    task = FactoryBot.build(:task, content: nil)
    task.valid?
    expect(task.errors.full_messages).to include "内容を入力してください"
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    task = FactoryBot.build(:task)
    expect(task.valid?).to eq true
  end
end
