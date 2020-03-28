require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  wait = Selenium::WebDriver::Wait.new(:timeout => 100) 
  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "session_email", with: 'test@example.com'
    fill_in "session_password", with: 'testtest'
    click_button "ログイン"
  end
  
  describe 'タスク機能一覧' do
    context 'タスクを作成した場合' do

      before do
        @task = FactoryBot.create(:task,user_id: @user.id)
      end
      it '作成されたタスクが表示されること' do
        # 一覧画面に遷移する
        visit tasks_path
        expect(page).to have_content 'test Title'
        expect(page).to have_content 'test Content'
      end
    end
    context '複数タスクを作成した場合' do
      before do
        task1 = FactoryBot.create(:task, title: 'test Title1', content: 'test Content1',priority: 0,user_id: @user.id)
        task2 = FactoryBot.create(:task, title: 'test Title2', content: 'test Content2',priority: 2,user_id: @user.id)
        task3 = FactoryBot.create(:task, title: 'test Title3', content: 'test Content3',priority: 1,user_id: @user.id)
      end
      it "タスクが優先度順に並んでいること", :retry => 3 do
        visit tasks_path
        task_list = all('.task_title')
        wait.until {expect(task_list[0]).to have_content "test Title2" }
        wait.until {expect(task_list[1]).to have_content "test Title3" }
        wait.until {expect(task_list[2]).to have_content "test Title1" }
      end
    end
    context '終了期限でソートを押した場合' do
      before do
        task = FactoryBot.create(:task, title: 'third title', content: 'third content', end_date: '2030-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'first title', content: 'first content', end_date: '1990-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'second title', content: 'second content', end_date: '2020-12-01',user_id: @user.id)
      end
      it 'タスクの並び順が終了期限の降順で並んでいること', :retry => 3 do
        visit tasks_path
        wait.until {click_link '終了期限でソート' }
        task_list = all('.task_title')
        wait.until {expect(task_list[0]).to have_content 'third title'}
        wait.until {expect(task_list[1]).to have_content 'second title'}
        wait.until {expect(task_list[2]).to have_content 'first title'}
      end
    end
    context '検索ボタンを押した場合' do
      before do
        task = FactoryBot.create(:task, title: 'third title', content: 'third content', end_date: '2030-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'first title', content: 'first content', end_date: '1990-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'second title', content: 'second content', end_date: '2020-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'status', content: 'second content', end_date: '2020-12-01', status: '着手中',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'status1', content: 'second content', end_date: '2020-12-01', status: '着手中',user_id: @user.id)
      end
      it '検索条件に該当したタイトルのみ表示されていること' do
        visit tasks_path
        fill_in 'title', with: 'third title'
        click_button '検索'
        task_list = all('.task_title')
        expect(task_list[0]).to have_content 'third title'
      end
      it '検索条件に該当しないタイトルは表示されていないこと', :retry => 3 do
        visit tasks_path
        fill_in 'title', with: 'third title'
        click_button '検索'
        task_list = all('.task_title')
        wait.until{ expect(task_list[0]).to_not have_content 'second content' }
      end
      it 'ステータスに該当するタイトルのみ表示すること' do
        visit tasks_path
        select '着手中', from: 'status'
        click_button '検索'
        task_list = all('.task_title')
        expect(task_list[0]).to have_content 'status'
      end
      it 'ステータスに該当しないタイトルは表示されないこと' do
        visit tasks_path
        select '着手中', from: 'status'
        click_button '検索'
        task_list = all('.task_title')
        expect(task_list[0]).to_not have_content "second content"
      end
      it '複合的な検索条件に該当するタイトルのみ表示すること' do
        visit tasks_path
        select '着手中', from: 'status'
        click_button '検索'
        task_list = all('.task_title')
        wait.until { expect(task_list[0]).to have_content "status1" }
        wait.until { expect(task_list[1]).to have_content "status" }
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it "データが保存されること" do
        visit tasks_path
        click_link 'new_link'
        fill_in "task_title", with: 'test Title10'
        fill_in "task_content", with: 'test Content10'
        click_button 'create_button'
        expect(page).to have_content '登録が完了しました！'
        expect(page).to have_content 'test Title10'
        expect(page).to have_content 'test Content10'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        FactoryBot.create(:task,user_id: @user.id)
      end
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit tasks_path
        click_link  'show_link'
        expect(page).to have_content('test Title')
        expect(page).to have_content('test Content')
        click_link 'back_show_link'
        expect(page).to have_content('test Title')
        expect(page).to have_content('test Content')
      end
    end
  end
  describe 'タスク編集画面' do
    context '任意のタスク編集画面に遷移した場合' do
      before do
        FactoryBot.create(:task,user_id: @user.id)
      end
      it '該当タスクの内容が更新され一覧ページに遷移すること' do
        visit tasks_path
        click_link 'edit_link'
        fill_in 'task_title', with: 'test Title edit'
        fill_in 'task_content', with: 'test Content edit'
        click_button 'create_button'
        expect(page).to have_content '更新に成功しました！'
        expect(page).to have_content 'test Title edit'
        expect(page).to have_content 'test Content edit'
      end
    end
  end
  describe 'タスクの削除' do
    before do
      FactoryBot.create(:task,user_id: @user.id)
    end
    context '任意のタスクを削除した場合' do
      it '該当のタスクが削除され、一覧ページに遷移すること' do
        visit tasks_path
        expect(page).to have_content 'test Title'
        expect(page).to have_content 'test Content'
        click_link 'delete_link'
        page.accept_confirm '削除してもよろしいですか？'
        expect(page).to have_content '削除しました！'
        expect(page).to_not have_content 'test Title'
        expect(page).to_not have_content 'test Content'
      end
    end
  end
  describe "ページネーションの機能" do
    before do
      26.times do |n|
        FactoryBot.create(:task, title: "test Title#{n}",user_id: @user.id)
      end
    end
    context "最大レコード数を超えた場合" do
      it "最大表示数の最終レコードが表示されていること" do
        visit tasks_path
        expect(page).to have_content "test Title25"
      end
      it "超えたレコードは表示されないこと" do
        visit tasks_path
        expect(page).to_not have_content "test Title26"
      end
    end
  end
end