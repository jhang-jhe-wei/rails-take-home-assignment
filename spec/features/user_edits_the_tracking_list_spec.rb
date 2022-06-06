# frozen_string_literal: true

require 'rails_helper'

describe 'User edits the tracking list' do
  context 'when current user has one tracking list' do
    let(:current_user) { create(:user) }

    before do
      create(:tracking_list, user_id: current_user.id)
      visit root_path
      click_link('編輯')
      fill_in 'Name', with: 'Updated List'
      click_button('Update Tracking list')
    end

    it 'expects to see name of the tracking_list has changed' do
      expect(page).to have_text('Updated List')
    end

    it 'expects to see the updated successfully message' do
      expect(page).to have_text('追蹤清單已成功修改')
    end
  end

  context 'when current user has many tracking lists' do
    let(:current_user) { create(:user) }

    before do
      create_list(:tracking_list, 3, user_id: current_user.id)
      visit root_path
      second_tracking_list.click_link('編輯')
      fill_in 'Name', with: 'Updated List'
      click_button('Update Tracking list')
    end

    it 'expects to see name of the second tracking list has changed' do
      expect(second_tracking_list).to have_text('Updated List')
    end

    def second_tracking_list
      all('div.tracking-list')[1]
    end
  end
end
