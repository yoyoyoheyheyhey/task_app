require 'rails_helper'

RSpec.describe Task, type: :model do
  # FoctoryBot.create(:task, title: 'test Title2', 
  #                          content: 'test Content2',
  #                          end_date: '2020-01-01', status: '完了', priority: 2)
  # FoctoryBot.create(:task, title: 'test Title3', 
  #                          content: 'test Content3',
  #                          end_date: '2020-01-01', status: '着手中', priority: 0)
  # FoctoryBot.create(:task, title: 'test Title4', 
  #                          content: 'test Content4',
  #                          end_date: '2020-01-01', status: '着手中', priority: 0)
  # FoctoryBot.create(:task, title: 'test Title5', 
  #                          content: 'test Content5-partial',
  #                          end_date: '2020-01-01', status: '着手中', priority: 0)
  # FoctoryBot.create(:task, title: 'test Title6-partial', 
  #                          content: 'test Content6',
  #                          end_date: '2020-01-01', status: '着手中', priority: 0)
  # it "指定したタイトルで検索できること" do
    # task = Task.create(title: "test Title1",
    #                    content: "test Content",
    #                    end_date: "2020-12-01",
    #                    status: "着手中",
    #                    priority: 0)
# let!(:task1) {create :task, title: "test Title1",
#                             content: "test Content",
#                             end_date: "2020-12-01",
#                             status: "着手中",
#                             priority: 0 }
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
