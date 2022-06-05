require 'rails_helper'

feature 'User switches to another user' do
  scenario 'they can see the current user has changed' do
    create_list(:user, 3)
    visit root_path
    expect(page).to have_text("現在使用者為： #{User.first.name}")
    select User.second.name, from: "切換使用者"
    expect(page).to have_text("現在使用者為： #{User.second.name}")
  end
end
