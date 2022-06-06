# frozen_string_literal: true

require 'rails_helper'

describe 'User deletes the tracking list' do
  context 'when current user has one tracking list' do
    let(:current_user) { create(:user) }

    before do
      create(:tracking_list, user_id: current_user.id)
      visit root_path
      accept_confirm { click_link('刪除') }
    end

    it 'expects to see the delete successfully message' do
      expect(page).to have_text('追蹤清單已成功刪除')
    end

    it 'expects to see the no tracking list message' do
      expect(page).to have_text('你還沒有建立股票清單哦！')
    end
  end

  context 'when current user has three tracking lists' do
    let(:current_user) { create(:user) }

    before do
      create_list(:tracking_list, 3, user_id: current_user.id)
      visit root_path
      accept_confirm { second_tracking_list.click_link('刪除') }
    end

    it 'expects to see two tracking list' do
      expect(all('div.tracking-list').count).to eq(2)
    end

    def second_tracking_list
      all('div.tracking-list')[1]
    end
  end
end
