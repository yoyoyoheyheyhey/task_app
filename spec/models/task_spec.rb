require 'rails_helper'
RSpec.describe Task, type: :model do
  describe "scope" do
    task = Task.create(title: "test Title1",
                    content: "test Content",
                    end_date: "2020-12-01",
                    status: "着手中",
                    priority: 0)
    task_slow = Task.create(title: "test Title slow",
                    content: "test Content",
                    end_date: "2090-12-01",
                    status: "完了",
                    priority: 0)

    task_status = Task.create(title: "test Title 3",
                    content: "test Content",
                    end_date: "2090-12-01",
                    status: "完了",
                    priority: 0)
        
    it "指定したタイトルで検索できること" do
      expect(Task.with_title("test Title1")[0].title).to include(task.title)
    end

    it "指定したステータスで検索できること" do
      expect(Task.with_status("完了")[0].status).to include(task_slow.status)
    end

    it "指定したタイトルとステータス両表で検索できること" do
      expect(Task.with_title("test").with_status("完了")[0].title).to include(task_slow.title)
      expect(Task.with_title("test").with_status("完了")[1].title).to include(task_status.title)
    end
  end
end