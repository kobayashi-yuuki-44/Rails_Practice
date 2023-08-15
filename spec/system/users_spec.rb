
require 'rails_helper'
  
RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe '確認観点1：ユーザー新規作成' do
    it '1-1：ユーザーの新規作成ができる' do
      # 確認対象の画面に移動
      visit 'users/new'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Last name'), 'Last name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'First name'), 'First name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='user_last_name']"), 'Last name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_first_name']"), 'First name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ユーザー作成用ボタンの存在確認
      expect(page).to have_button('Create User'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      # ユーザー新規作成用の処理
      expect {
        fill_in 'Last name', with: 'test01'
        fill_in 'First name', with: 'test01'
        fill_in 'Email', with: 'test01@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Create User'
      }.to change { User.count }.by(1) # 処理結果の確認
      expect(current_path).to eq('/login'), 'ユーザー作成後にログイン画面に遷移できていません'
    end

    it '1-2：同じメールアドレスのユーザーは新規作成できない' do
      # テストデータの用意
      user = create(:user) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit 'users/new'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Last name'), 'Last name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'First name'), 'First name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='user_last_name']"), 'Last name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_first_name']"), 'First name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ユーザー作成用ボタンの存在確認
      expect(page).to have_button('Create User'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      # ユーザー新規作成用の処理
      expect {
        fill_in 'Last name', with: 'test01'
        fill_in 'First name', with: 'test01'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Create User'
      }.to change { User.count }.by(0) # 処理結果の確認
    end

    it '1-3：入力項目が不足している場合に新規作成ができない' do
      # 確認対象の画面に移動
      visit 'users/new'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Last name'), 'Last name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'First name'), 'First name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='user_last_name']"), 'Last name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_first_name']"), 'First name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ユーザー作成用ボタンの存在確認
      expect(page).to have_button('Create User'), 'ユーザー作成用のボタンが表示されていることを確認してください'

      # ユーザー新規作成用の処理
      expect {
        fill_in 'Last name', with: nil
        fill_in 'First name', with: nil
        fill_in 'Email', with: nil
        fill_in 'Password', with: nil
        fill_in 'Password confirmation', with: nil
        click_on 'Create User'
      }.to change { User.count }.by(0) # 処理結果の確認
    end
  end
end
