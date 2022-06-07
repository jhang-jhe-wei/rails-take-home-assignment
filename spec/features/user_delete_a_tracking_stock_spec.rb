# frozen_string_literal: true

require 'rails_helper'

describe 'User deletes the tracking stock record' do
  fixtures :stocks
  let (:current_user) { create(:user) }
  before do
    tracking_list = create(:tracking_list, user_id: current_user.id)
    Stock.all.each { |stock| tracking_list.stocks << stock }
    visit root_path
  end

  subject { all('div.tracking-list div.tracking-stock-records')[0] }
  it 'expects to see delete link in tracking stock' do
    is_expected.to have_link('刪除')
  end

  context 'when delete tmsc' do
    before do
      accept_confirm { all('div.tracking-stock-record', text: stocks(:tsmc).name)[0].click_link('刪除') }
    end

    it "expects see delete successfully message" do
      expect(page).to have_text('刪除成功')
    end

    it "expects tmsc does not in the page" do
      expect(page).not_to have_text(stocks(:tsmc).name)
    end
  end
end
