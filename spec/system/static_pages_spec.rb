require 'rails_helper'

RSpec.describe 'Static_pages', type: :system do

  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ヘッダー確認' do
      it 'ログインリンクの表示があること' do
        visit root_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'ログイン後' do
    before do
      driven_by(:chrome)
    end  
    it 'ログアウトリンクの表示があること', js: true do
      visit root_path
      login_as(user)
      expect(page).to have_content 'ログアウト'
    end
  end
end