# frozen_string_literal: true

require 'rails_helper'

describe 'User creates a tracking stock record' do
  fixtures :stocks
  let (:current_user) { create(:user) }
  before do
    create(:tracking_list, user_id: current_user.id)
    visit root_path
    click_link('點我新增追蹤股')
  end

  it 'expects to see the stock list on the page' do
    Stock.all.each { |stock| expect(page).to have_text(stock.name) }
  end

  it 'expect to see tracking list name on the page' do
    #need to improve
    sleep(1)
    expect(page).to have_text(TrackingList.first.name)
  end

  context 'when user fill in the correct stock code' do
    before do
      fill_in '請輸入股號', with: Stock.first.code
      click_button('Create Tracking stock record')
    end

    it 'expects to see create successfully message in the landing page' do
      expect(page).to have_text('已加入追蹤清單')
    end

    it 'expects to see stock list in the tracking list' do
      expect(all('div.tracking-list')[0]).to have_text(Stock.first.name)
    end
  end

  context 'when user fill in the incorrect stock code' do
    before do
      fill_in '請輸入股號', with: '50'
      click_button('Create Tracking stock record')
    end

    it 'expects to see stock does not exist message in the current page' do
      expect(page).to have_text('Stock must exist')
    end
  end

  context 'when user fill in the stock code which already in the same tracking list' do
    before do
      current_user.tracking_lists.first.stocks << Stock.first
      fill_in '請輸入股號', with: Stock.first.code
      click_button('Create Tracking stock record')
    end

    it 'expects to see stock aleady in the same tracking list in the current page' do
      expect(page).to have_text('Stock aleady exists')
    end
  end

end
