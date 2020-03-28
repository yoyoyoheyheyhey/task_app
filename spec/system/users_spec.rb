require 'rails_helper'

RSpec.describe "Users", type: :system do

  wait = Selenium::WebDriver::Wait.new(:timeout => 100) 

  describe '一般ユーザー' do
    context '一般ユーザーにて登録した場合' do
      it 'タスク一覧画面表示されること', :retry => 3 do
        visit new_user_path
        fill_in "user_name", with: 'test User1'
        fill_in "user_email", with: 'test1@example.com'
        fill_in "user_password", with: 'testtest'
        fill_in "user_password_confirmation", with: 'testtest'
        click_button "登録"
        wait.until{ expect(page).to have_content "タスク一覧" }
      end
    end
    context '一般ユーザーがログアウトした場合' do
      it "ログイン画面にリダイレクトされること", :retry => 3 do
        visit new_user_path
        fill_in "user_name", with: 'test User1'
        fill_in "user_email", with: 'test1@example.com'
        fill_in "user_password", with: 'testtest'
        fill_in "user_password_confirmation", with: 'testtest'
        click_button "登録"
        wait.until{ expect(page).to have_content "タスク一覧" }
        click_link "ログアウト"
        wait.until{ expect(page).to have_content "ログアウトしました！" }
        visit tasks_path
        wait.until{ expect(page).to have_content "ログイン画面" }
      end
    end
  end

  before do
    admin_user = FactoryBot.create(:user, name: 'test UserAdmin',
                                          email: 'testAdmin@example.com',
                                          admin: true,
                                          password: "testtest",
                                          password_confirmation: "testtest")
  end
  describe "管理者ユーザー" do
    context "管理者ユーザーにてログイン処理をした際" do
      it "管理者画面が表示されていること" do
        visit new_session_path
        fill_in "session_email", with: "testadmin@example.com"
        fill_in "session_password", with: "testtest"
        click_button "ログイン"
        wait.until { expect(page).to have_content "管理者としてログインしました！" }
      end
    end
    context "ユーザー新規で管理者権限を持つユーザーおん登録処理をした際" do
      it "新しい管理者ユーザーが管理者画面に表示されること" do
        visit new_session_path
        fill_in "session_email", with: "testadmin@example.com"
        fill_in "session_password", with: "testtest"
        click_button "ログイン"
        wait.until{ click_link "user_create" }
        fill_in "user_name", with: "test User1"
        fill_in "user_email", with: "test1@example.com"
        check "user_admin"
        fill_in "user_password", with: "testtest"
        fill_in "user_password_confirmation", with: "testtest"
        click_button "登録"
        wait.until{ expect(page).to have_content "test User1" }
        wait.until{ expect(page).to have_content "管理者" }
      end
    end
  end
end
