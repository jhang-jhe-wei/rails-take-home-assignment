# frozen_string_literal: true

require 'rails_helper'

describe 'User creates a tracking list' do
  before do
    create(:user)
    visit root_path
    click_button('點我建立新的追蹤清單')
    fill_in 'Name', with: 'list1'
    click_button('Create Tracking list')
  end

  it 'expects to see new tracking list' do
    expect(page).to have_text('list1')
  end


  it 'expects to see new tracking stock record link' do
    expect(page).to have_link('點我新增追蹤股')
  end


  it 'expects to see created successfully message' do
    expect(page).to have_text('追蹤清單已建立')
  end

  it 'does not expect to see no tracking list message' do
    # need to improve
    sleep(1)
    expect(page).not_to have_content('你還沒有建立股票清單哦！')
  end

  context 'when switches to other user' do
    before do
      create_list(:user, 2)
      visit root_path
      click_button('點我建立新的追蹤清單')
      fill_in 'Name', with: 'list1'
      click_button('Create Tracking list')
      select User.second.name, from: '切換使用者'
    end

    it 'expects to see no tracking list message' do
      expect(page).to have_content('你還沒有建立股票清單哦！')
    end
  end
end
