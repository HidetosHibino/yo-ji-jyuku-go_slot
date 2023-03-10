module LoginMacros
  def login_as(user)
    click_link 'ログイン'
    expect(page).to have_content 'メールアドレス'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end
end