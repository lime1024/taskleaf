require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザ A', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザ B', email: 'b@example.com') }
    let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end
    
    describe '一覧表示機能' do
      context 'ユーザ A がログインしているとき' do
        let(:login_user) { user_a }

        it 'ユーザ A が作成したタスクが表示される' do
          expect(page).to have_content '最初のタスク'
        end
      end

      context 'ユーザ B がログインしているとき' do
        let(:login_user) { user_b }

        it 'ユーザ A が作成したタスクが表示されない' do
          expect(page).not_to have_content '最初のタスク'
        end
      end
    end

    describe '詳細表示機能' do
      context 'ユーザ A がログインしているとき' do
        let(:login_user) { user_a }

        before do
          visit task_path(task_a)
        end

        it 'ユーザ A が作成したタスクが表示される' do
          expect(page).to have_content '最初のタスク'
        end
      end
    end
  end
end
