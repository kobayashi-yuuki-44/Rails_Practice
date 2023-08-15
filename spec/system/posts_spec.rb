require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe '確認観点4：投稿機能' do
    let!(:user){ create(:user) }
    let(:another_user){ create(:user) }

    before do
      # 確認対象の画面に移動
      visit '/login'

      # labelの存在確認
      expect(page).to have_selector('label',text: 'Email'), 'Email というラベルが表示されていることを確認してください'
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
    end

    it '4-1：自分の投稿を編集することができる' do
      create(:post, user: user)

      # 確認対象の画面に移動
      visit '/posts'

      # 編集リンクの存在確認
      expect(page).to have_content('Edit'), '自分の投稿に編集用のリンクが表示されているかを確認してください'
      click_on 'Edit'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'Title'), 'Title というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'Content'), 'Content というラベルが表示されていることを確認してください'

      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='post_title']"), 'Title というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='post_content']"), 'Content というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

      # 更新ボタンの存在確認
      expect(page).to have_button('Update Post'), '編集画面に更新用のボタンが表示されているかを確認してください'

      # 投稿編集と更新処理
      fill_in 'Title', with: 'edited_title'
      fill_in 'Content', with: 'edited_content'
      click_on 'Update Post'

      # 処理結果の確認
      expect(current_path).to eq(post_path(Post.find_by(title: 'edited_title'))), '投稿編集後に投稿詳細画面に遷移できていません'
      expect(page).to have_content('edited_title'), '編集した投稿のタイトルが表示されていません'
      expect(page).to have_content('edited_content'), '編集した投稿の本文が表示されていません'
    end

    it '4-2：自分の投稿を削除することができる' do
      post = create(:post, user: user)

      # 確認対象の画面に移動
      visit '/posts'

      # 削除リンクの存在確認
      expect(page).to have_content('Destroy'), '自分の投稿に削除用のリンクが表示されているかを確認してください'
      page.accept_confirm { click_on 'Destroy' }

      # 処理結果の確認
      expect(current_path).to eq('/posts'), '投稿削除後に投稿一覧画面に遷移できていません'
      expect(page).not_to have_content(post.title), '投稿が削除できているかを確認してください'
    end

    it '4-3：他人の投稿に編集リンクが表示されない' do
      create(:post, user: another_user)

      # 確認対象の画面に移動
      visit '/posts'
      expect(page).not_to have_link('Edit'), '他人の投稿に編集リンクが表示されています'
    end

    it '4-4：他人の投稿に削除リンクが表示されない' do
      create(:post, user: another_user)

      # 確認対象の画面に移動
      visit '/posts'
      expect(page).not_to have_link('Destroy'), '他人の投稿に削除リンクが表示されています'
    end
  end
end
