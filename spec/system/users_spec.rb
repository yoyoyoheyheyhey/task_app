require 'rails_helper'

RSpec.describe "Users", type: :system do

  wait = Selenium::WebDriver::Wait.new(:timeout => 100) 
  describe '一般ユーザー' do
    context "ログイン画面に遷移するためのリクエストが複数存在する場合" do
      it "root_pathでのアクセスでもログイン画面が表示されること" do
        visit root_path
        wait.until{ expect(page).to have_content "ログイン画面" }
      end
      it "/loginでのアクセスでもログイン画面が表示されること" do
        visit '/login'
        wait.until{ expect(page).to have_content "ログイン画面" }
      end
    end
    context '一般ユーザーにて登録した場合' do
      before do
      end
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
    context "一般ユーザーがログインをした場合" do
      before do
        @user = FactoryBot.create(:user, name: 'test User1',
                                         email: 'test1@example.com',
                                         created_at: '2020-01-01 01:01:01',
                                         updated_at: '2020-01-02 01:01:01')
        @task = FactoryBot.create(:task, title: "test Title 1",
                                         end_date: '2020-01-31',
                                         user_id: @user.id,
                                         created_at: '2020-01-01 01:01:01',
                                         updated_at: '2020-01-02 01:01:01')
        @other = FactoryBot.create(:user, name: 'test User2',
                                          email: 'test2@example.com',
                                          created_at: '2020-01-01 01:01:01',
                                          updated_at: '2020-01-02 01:01:01')
        @other_task = FactoryBot.create(:task, title: "test Title 2",
                                               end_date: '2020-01-31',
                                               user_id: @other.id,
                                               created_at: '2020-01-01 01:01:01',
                                               updated_at: '2020-01-02 01:01:01')
        visit new_session_path
        fill_in "session_email", with: "test1@example.com"
        fill_in "session_password", with: "testtest"
        click_button "ログイン"
      end
      it "自分のタスク一覧画面にリダイレクトされること" do
        wait.until{ expect(page).to have_content "test Title 1" }
        wait.until{ expect(page).to_not have_content "test Title 2" }
      end

      it "自分のタスク詳細画面へページ遷移できること" do
        wait.until{ all(".border-content")[0].click_link "詳細" }
        wait.until{ expect(page).to have_content "タスク詳細" }
        wait.until{ expect(page).to have_content "2020年01月31日" }
        wait.until{ expect(page).to have_content "2020年01月01日01時01分01秒"}
        wait.until{ expect(page).to have_content "2020年01月02日01時01分01秒"}
      end

      it "別ユーザーのマイページ(詳細)にアクセスした際、自分のタスク一覧画面にリダイレクトされること" do
        visit user_path(@other.id)
        wait.until{ expect(page).to have_content "test Title 1" }
        wait.until{ expect(page).to_not have_content "test Title 2" }
      end

      it "ログインしている状態で、登録画面にアクセスした場合、タスク一覧画面にリダイレクトされること" do
        visit new_user_path
        wait.until{ expect(page).to have_content "test Title 1" }
      end

      it "プロフィールリンクを押した際、対象のユーザーの詳細画面に遷移すること" do
        click_link "プロフィール"
        wait.until{ expect(page).to have_content "test User1" }
      end
    end

    context "一般ユーザーがログインしていない場合" do
      before do
        user = FactoryBot.create(:user)
        task = FactoryBot.create(:task, user_id: user.id)
      end
      it "タスク一覧画面にアクセスした場合ログイン画面に遷移すること" do
        visit tasks_path
        wait.until{ expect(page).to have_content "ログイン画面" }
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

  describe "管理者ユーザー" do
    before do
      admin_user = FactoryBot.create(:user, name: 'test UserAdmin',
                                            email: 'testAdmin@example.com',
                                            admin: true,
                                            password: "testtest",
                                            password_confirmation: "testtest")
      other_user1 = FactoryBot.create(:user, name: 'test User1',
                                            email: 'test1@example.com',
                                            admin: false,
                                            password: "testtest",
                                            password_confirmation: "testtest")
      FactoryBot.create(:task, title: "test User show",
                               user_id: other_user1.id)
      FactoryBot.create(:task, title: "test User show2",
                               user_id: other_user1.id)
      FactoryBot.create(:task, title: "test User show3",
                               user_id: other_user1.id)

      visit new_session_path
      fill_in "session_email", with: "testadmin@example.com"
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
    end

    context "管理者ユーザーにてログイン処理をした際" do
      it "管理者画面が表示されていること" do
        wait.until { expect(page).to have_content "管理者としてログインしました！" }
      end
    end

    context "新規でユーザー登録処理をした際" do
      it "新しいユーザーが管理者画面に表示されること" do
        wait.until{ click_link "user_create" }
        fill_in "user_name", with: "test User1"
        fill_in "user_email", with: "testNew@example.com"
        check "user_admin"
        fill_in "user_password", with: "testtest"
        fill_in "user_password_confirmation", with: "testtest"
        click_button "登録する"
        wait.until{ expect(page).to have_content "test User1" }
        wait.until{ expect(page).to have_content "管理者" }
      end
      it "ユーザーの登録処理に失敗した場合、新規作成画面に遷移すること" do
        wait.until{ click_link "user_create" }
        click_button "登録する"
        wait.until{ expect(page).to have_content "ユーザーの作成に失敗しました！" }
      end
    end

    context "ユーザーの更新処理をした場合" do
      it "変更後のユーザー情報が表示されていること" do
        wait.until{ all('.border-content')[0].click_link "編集" }
        fill_in "user_name", with: "test Edit User"
        fill_in "user_email", with: "edit@example.com"
        fill_in "user_password", with:"testtest"
        fill_in "user_password_confirmation", with: "testtest"
        wait.until{ click_button "更新する" }
        wait.until{ expect(page).to have_content "test Edit User" }
      end
    end

    context "ユーザーの削除処理をした場合" do
      it "ユーザー一覧画面に削除したユーザーが表示されていないこと" do
        wait.until{ all('.border-content')[0].click_link "削除" }
        page.driver.browser.switch_to.alert.accept
        wait.until{ expect(page).to have_content "test UserAdmin" }
        wait.until{ expect(page).to_not have_content "test User1" }
      end
      it "削除対象がログインしている管理者ユーザーの場合、削除できないこと" do
        visit admin_users_path
        wait.until{ all(".border-content")[1].click_link "削除" }
        page.driver.browser.switch_to.alert.accept
        wait.until{ expect(page).to have_content "自身を削除することはできません！" }
      end
    end

    context "ユーザーの詳細ボタンを押した場合" do
      it "対象のユーザーのタスクが表示されていること" do
        wait.until{ all('.border-content')[0].click_link "詳細" }
        wait.until{ expect(page).to have_content "test User show" }
      end
    end

    context "一般ユーザーが管理者画面にアクセスした場合" do
      it "ログイン画面にリダイレクトすること" do
        visit admin_users_path
        click_link "ログアウト"
        visit new_session_path
        fill_in "session_email", with: "test1@example.com"
        fill_in "session_password", with: "testtest"
        click_button "ログイン"
        visit admin_users_path
        wait.until{ expect(page).to have_content "あなたは管理者ではありません!" }
      end
    end
    context "ユーザー一覧にてタスクを登録しているユーザーが存在した場合" do
      it "タスクの合計が表示されていること" do
        visit admin_users_path
        expect(page).to have_content "3"
      end
    end
    context "管理者ユーザーにて別ユーザーに対してタスクの登録処理をした場合" do
      it "対象のユーザーのタスク一覧に作成したタスクが表示されること" do
        visit admin_users_path
        wait.until{ all(".border-content")[0].click_link "詳細" }
        wait.until{ click_link "タスク作成" }
        fill_in "task_title", with: 'test Title admin'
        fill_in "task_content", with: 'test Content admin'
        fill_in "終了期限", with: "2020-01-30"
        click_button 'create_button'
        wait.until{ expect(page).to have_content "test Title admin" }
      end
    end
    context "管理者ユーザーにて別ユーザーのタスクの更新処理をした場合", :retry => 3 do
      it "対象のユーザーのタスク一覧に更新した内容が表示されること" do
        visit admin_users_path
        wait.until{ all(".border-content")[0].click_link "詳細" }
        wait.until{ all(".border-content")[0].click_link "編集" }
        fill_in "task_title", with: 'test Title admin update'
        fill_in "task_content", with: 'test Content admin update'
        fill_in "終了期限", with: "2020-01-30"
        click_button 'create_button'
        wait.until{ expect(page).to have_content "test Content admin update" }
      end
    end
    context "管理者ユーザーにて別ユーザーのタスクの詳細リンクを押した場合", :retry => 3 do
      it "対象のユーザーのタスク詳細が閲覧できること" do
        visit admin_users_path
        wait.until{ all(".border-content")[0].click_link "詳細" }
        wait.until{ all(".border-content")[0].click_link "詳細" }
        wait.until{ expect(page).to have_content "est User show" }
      end
    end
    context "管理者ユーザーにて別ユーザーのタスクを削除した場合", :retry => 5 do
      it "対象のユーザーのタスク一覧から対象のタスクが削除されていること" do
        visit admin_users_path
        wait.until{ all(".border-content")[0].click_link "詳細" }
        sleep(1)
        wait.until{ all(".border-content")[0].click_link "削除" }
        page.driver.browser.switch_to.alert.accept
        wait.until{ expect(page).to_not have_content "test User show3" }
      end
    end
  end
end
