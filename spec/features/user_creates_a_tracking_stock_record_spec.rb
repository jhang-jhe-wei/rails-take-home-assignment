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
    expect(page).to have_text(TrackingList.first.name)
  end
end
