# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TrackingList, type: :model do
  describe '#calculate_row_order' do
    let(:current_user) { User.create(name: 'tester') }

    context 'when current user add their first tracking list' do
      subject { current_user.tracking_lists.create(name: 'list1') }

      let(:other_user) { create(:user) }

      before { create(:tracking_list, user_id: other_user.id) }

      its(:row_order) { is_expected.to eq(1) }

      it 'Other user add their first tracking list' do
        expect(other_user.tracking_lists.first.row_order).to eq(1)
      end
    end

    context 'when current user has 5 tracking lists, remove the second tracking list and add a new tracking list' do
      subject { current_user.tracking_lists.create(name: 'new list') }

      before do
        5.times { |i| current_user.tracking_lists.create(name: "list#{i}") }
        current_user.tracking_lists.second.destroy
      end

      let(:max_order) { current_user.tracking_lists.maximum(:row_order) }

      its(:row_order) { is_expected.to eq(6) }
    end
  end

  describe '#down' do
    context 'when current user has 10 tracking lists' do
      before do
        user = create(:user)
        create_list(:tracking_list, 10, user_id: user.id)
        tracking_list.down
      end

      let!(:tracking_list) { described_class.find_by(row_order: 9) }

      it 'down the tracking list which order is 9' do
        expect(described_class.order(:id).pluck(:row_order)).to eq([1, 2, 3, 4, 5, 6, 7, 9, 8, 10])
      end
    end

    context 'when current user has 8 tracking lists' do
      before do
        user = create(:user)
        create_list(:tracking_list, 8, user_id: user.id)
        tracking_list.down
      end

      let!(:tracking_list) { described_class.order(row_order: :ASC).first }

      it 'down the tracking list which order is 1' do
        expect(described_class.order(:id).pluck(:row_order)).to eq([1, 2, 3, 4, 5, 6, 7, 8])
      end
    end

    context 'when current user only has one tracking list, after down' do
      subject { described_class.find_by(id: tracking_list.id) }

      before do
        user = User.create(name: 'tester')
        user.tracking_lists.create(name: 'list1')
        tracking_list.down
      end

      let!(:tracking_list) { described_class.first }

      its(:row_order) do
        is_expected.to eq(1)
      end
    end
  end

  describe '#up' do
    context 'when current user has 10 tracking lists' do
      before do
        user = create(:user)
        create_list(:tracking_list, 10, user_id: user.id)
        tracking_list.up
      end

      let(:tracking_list) { described_class.find_by(row_order: 9) }

      it 'Order of the tracking list is 9, after up' do
        expect(described_class.order(:id).pluck(:row_order)).to eq([1, 2, 3, 4, 5, 6, 7, 8, 10, 9])
      end
    end

    context 'when current user has 8 tracking lists' do
      before do
        user = create(:user)
        create_list(:tracking_list, 8, user_id: user.id)
        tracking_list.up
      end

      let(:tracking_list) { described_class.find_by(row_order: 8) }

      it 'Order of the tracking list is 8, after up' do
        expect(described_class.order(:id).pluck(:row_order)).to eq([1, 2, 3, 4, 5, 6, 7, 8])
      end
    end

    context 'when current user only has one tracking list, after up' do
      subject { described_class.find_by(id: tracking_list.id) }

      let(:tracking_list) { described_class.first }

      before do
        user = User.create(name: 'tester')
        user.tracking_lists.create(name: 'list1')
        tracking_list.up
      end

      its(:row_order) do
        is_expected.to eq(1)
      end
    end
  end
end
