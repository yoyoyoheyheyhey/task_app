require 'rails_helper'

RSpec.describe "Users", type: :system do
  wait = Selenium::WebDriver::Wait.new(:timeout => 100) 
  describe 'ユーザー登録' do
    context 'ユーザーを作成した時' do
      it '作成されたユーザーが表示されること', :retry => 3 do
        visit new_user_path
        fill_in "user_name", with: 'test User1'
        fill_in "user_email", with: 'test1@example.com'
        fill_in "user_password", with: 'testtest'
        fill_in "user_password_confirmation", with: 'testtest'
        click_button "登録"
        wait.until{ expect(page).to have_content "test User1" }
      end
    end
    context 'ユーザーがログアウトした場合' do
      it "ログイン画面にリダイレクトされること", :retry => 3 do
        visit new_user_path
        fill_in "user_name", with: 'test User1'
        fill_in "user_email", with: 'test1@example.com'
        fill_in "user_password", with: 'testtest'
        fill_in "user_password_confirmation", with: 'testtest'
        click_button "登録"
        wait.until{ expect(page).to have_content "test User1" }
        click_link "ログアウト"
        wait.until{ expect(page).to have_content "ログアウトしました！" }
        visit tasks_path
        wait.until{ expect(page).to have_content "ログイン画面" }
      end
    end
  end
end
