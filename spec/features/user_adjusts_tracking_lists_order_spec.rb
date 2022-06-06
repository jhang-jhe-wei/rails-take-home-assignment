# frozen_string_literal: true

require 'rails_helper'

describe 'User adjusts tracking lists order' do
  let (:current_user) { create(:user) }
  before do
    create_list(:tracking_list, 3, user_id: current_user.id)
    visit root_path
  end

  it 'expects last created tracking_list is the first in the page' do
    expect(all('div.tracking-list')[0]).to have_text(TrackingList.last.name)
  end

  context 'When current user down the first tracking list in the page' do
    let (:first_tracking_list) { all('div.tracking-list')[0] }
    before do
      first_tracking_list.click_link("下移")
    end

    it 'expects to see the tracking list move to the second position' do
      expect(all('div.tracking-list')[1]).to have_text(TrackingList.last.name)
    end
  end
end
