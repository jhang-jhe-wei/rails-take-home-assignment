require 'rails_helper'

feature 'User visits landing page' do
  scenario 'they see an empty message and a create button' do
    create(:user)
    visit root_path

    expect(page).to have_text("你還沒有建立股票清單哦！")
    expect(page).to have_button("點我建立新的追蹤清單")
  end
end
