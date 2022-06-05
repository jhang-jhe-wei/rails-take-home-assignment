# frozen_string_literal: true

require 'rails_helper'

describe 'User visits landing page' do
  before do
    create(:user)
    visit root_path
  end

  it 'expects to see no tracking list message' do
    expect(page).to have_text('你還沒有建立股票清單哦！')
  end

  it 'expects to see the create tracking list button' do
    expect(page).to have_button('點我建立新的追蹤清單')
  end
end
