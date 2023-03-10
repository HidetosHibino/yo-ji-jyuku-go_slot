require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前'
    xit 'completes yubinbango automatically with JS' do
      # User編集画面を開く
      visit root_path
      click_button ''
      expect(page).to have_field '名前', with: 'いとう'
    end
end