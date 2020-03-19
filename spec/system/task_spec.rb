require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク機能一覧' do
    context 'タスクを作成した場合' do
      before do
        @task = Task.create!(title: 'test Title1',
                             content: 'test Content1',
                             )
      end
      it '作成されたタスクが表示されること' do
        # 一覧画面に遷移する
        visit root_path
        expect(page).to have_content 'test Title1'
        expect(page).to have_content 'test Content1'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it "データが保存されること" do
        visit root_path
        click_link 'new_link'
        fill_in "Title", with: 'test Title2'
        fill_in "Content", with: 'test Content2'
        click_button 'create_button'
        expect(page).to have_content '登録が完了しました！'
        expect(page).to have_content 'test Title2'
        expect(page).to have_content 'test Content2'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        @task = Task.create!(title: 'test Title3',
                            content: 'test Content3')
      end
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit root_path
        click_link  'show_link'

        expect(page).to have_content('test Title3')
        expect(page).to have_content('test Content3')
        click_link 'back_show_link'
        expect(page).to have_content('test Title3')
        expect(page).to have_content('test Content3')
      end
    end
  end
  describe 'タスク編集画面' do
    context '任意のタスク編集画面に遷移した場合' do
      before do
        @task = Task.create(title: 'test Title4',
                            content: 'test Content4')
      end
      it '該当タスクの内容が更新され一覧ページに遷移すること' do
        visit root_path
        click_link 'edit_link'
        fill_in 'Title', with: 'test Title edit'
        fill_in 'Content', with: 'test Content edit'
        click_button 'create_button'
        expect(page).to have_content '更新に成功しました！'
        expect(page).to have_content 'test Title edit'
        expect(page).to have_content 'test Content edit'
      end
    end
  end
  describe 'タスクの削除' do
    before do
      @task = Task.create(title: 'test Title5',
                          content: 'test Content5')
    end
    context '任意のタスクを削除した場合' do
      it '該当のタスクが削除され、一覧ページに遷移すること' do
        visit root_path
        expect(page).to have_content 'test Title5'
        expect(page).to have_content 'test Content5'
        click_link 'delete_link'
        page.accept_confirm '削除してもよろしいですか？'
        expect(page).to have_content '削除しました！'
        expect(page).to_not have_content 'test Title5'
        expect(page).to_not have_content 'test Content5'
      end
    end
  end
end