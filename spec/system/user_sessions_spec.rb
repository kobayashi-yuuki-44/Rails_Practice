
require 'rails_helper'
  
RSpec.describe "UserSessions", type: :system do
  describe '確認観点2：ユーザーログイン' do
    it '2-1：ユーザーのログインができる' do
      # テストデータの用意
      user = create(:user) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit '/login'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ログイン用ボタンの存在確認
      expect(page).to have_button('Login'), 'ログイン用のボタンが表示されていることを確認してください'

      # ユーザーログイン処理
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'

      # 処理結果の確認
      expect(current_path).not_to eq('/login'), 'ログイン処理が正しく行えるかを確認してください'
      expect(current_path).to eq('/posts'), 'ログイン後に投稿一覧画面に遷移できていません'
    end

    it '2-2：入力項目が不足している場合にログインができない' do
      # テストデータの用意
      user = create(:user) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit '/login'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ログイン用ボタンの存在確認
      expect(page).to have_button('Login'), 'ログイン用のボタンが表示されていることを確認してください'

      # ユーザーログイン処理
      fill_in 'Email', with: nil
      fill_in 'Password', with: nil
      click_button 'Login'

      # 処理結果の確認
      expect(current_path).not_to eq('/posts'), '入力項目が不足している場合にログインできていないかを確認してください'
      expect(current_path).to eq('/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '2-3：存在しないユーザーでログインができない' do
      # テストデータの用意
      user = create(:user) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit '/login'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ログイン用ボタンの存在確認
      expect(page).to have_button('Login'), 'ログイン用のボタンが表示されていることを確認してください'

      # ユーザーログイン処理
      fill_in 'Email', with: 'another_user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Login'

      # 処理結果の確認
      expect(current_path).not_to eq('/posts'), '存在しないユーザーでログインできていないかを確認してください'
      expect(current_path).to eq('/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '2-4：パスワードが間違っている場合にログインができない' do
      # テストデータの用意
      user = create(:user) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit '/login'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ログイン用ボタンの存在確認
      expect(page).to have_button('Login'), 'ログイン用のボタンが表示されていることを確認してください'

      # ユーザーログイン処理
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrong_password'
      click_button 'Login'

      # 処理結果の確認
      expect(current_path).not_to eq('/posts'), 'パスワードが間違っている場合にログインできていないかを確認してください'
      expect(current_path).to eq('/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '2-5：複数ユーザー登録時に問題なくログインができる' do
      # テストデータの用意
      first_user = create(:user) # describe使わないので、let!を使わずに記載
      second_user = create(:user) # describe使わないので、let!を使わずに記載
      third_user = create(:user) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit '/login'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ログイン用ボタンの存在確認
      expect(page).to have_button('Login'), 'ログイン用のボタンが表示されていることを確認してください'

      # ユーザーログイン処理
      fill_in 'Email', with: second_user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'

      # 処理結果の確認
      expect(current_path).not_to eq('/login'), 'ログイン処理が正しく行えるかを確認してください'

      find('#header-profile').click
      expect(page).not_to have_content("#{first_user.last_name} #{first_user.first_name}"), '最初に登録されたユーザーでログインされています。ログイン時のロジックを確認してください'
      expect(page).to have_content("#{second_user.last_name} #{second_user.first_name}"), '複数のユーザーを作成した状態で、正しくログインができるかを確認してください'
      expect(page).not_to have_content("#{third_user.last_name} #{third_user.first_name}"), '最後に登録されたユーザーでログインされています。ログイン時のロジックを確認してください'
    end
  end

  describe '確認観点3：ユーザーログアウト' do
    it '3-1：ユーザーのログアウトができる' do
      # テストデータの用意
      user = create(:user) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit '/login'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # ログイン用ボタンの存在確認
      expect(page).to have_button('Login'), 'ログイン用のボタンが表示されていることを確認してください'

      # ユーザーログイン処理
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'

      # ユーザーログアウト処理
      find('#header-profile').click

      # ログアウト用ボタンの存在確認
      expect(page).to have_link('Logout'), 'ログアウトのボタンが表示されていることを確認してください'

      click_on 'Logout'

      # 処理結果の確認
      expect(page).to have_button('Login'), 'ログアウトができているかを確認してください'
    end

    it '3-2：ログインしていない場合、ユーザーのログアウトリンクが表示されない' do
      # 確認対象の画面に移動
      visit '/login'

      # 処理結果の確認
      expect(page).not_to have_link('Logout'), 'ログインしていない場合でも、ログアウトリンクが表示されています'
    end
  end
end
