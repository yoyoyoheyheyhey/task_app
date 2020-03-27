require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー登録一覧' do
    context 'ユーザーを作成した時' do
      it '作成されたユーザーが表示されること' do
        visit new_user_path
        fill_in "user_name", with: 'test User1'
        fill_in "user_email", with: 'test1@example.com'
        fill_in "user_password", with: 'testtest'
        fill_in "user_password_confirmation", with: 'testtest'
        click_button "登録"
        expect(page).to have_content "test User1"
      end
    end
  end
end
