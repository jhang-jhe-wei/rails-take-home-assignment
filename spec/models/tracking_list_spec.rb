require 'rails_helper'

RSpec.describe TrackingList, type: :model do
  describe '#calculate_row_order' do
    let (:current_user) { User.create(name: "tester") }

    context 'When current user add their first tracking list' do
      subject { current_user.tracking_lists.create(name: "list1") }
      its(:row_order)  { is_expected.to eq(1) }

      context 'Other user add their first tracking list' do
        let (:other_user) { User.create(name: "other user") }
        subject { other_user.tracking_lists.create(name: "list1") }
        its(:row_order)  { is_expected.to eq(1) }
      end
    end

    context 'When current user has 5 tracking lists' do
      context 'remove the second tracking list and add a new tracking list' do
        before do
          5.times {|i| current_user.tracking_lists.create(name: "list#{i}") }
          current_user.tracking_lists.second.destroy
        end

        let (:max_order) { current_user.tracking_lists.maximum(:row_order) }
        subject { current_user.tracking_lists.create(name: "new list") }
        its(:row_order) { is_expected.to eq(6) }
      end
    end
  end

  describe '#down' do
    context 'When current user has 10 tracking lists' do
      before do
        user = User.create(name: "tester")
        create_list(:tracking_list, 10, user_id: user.id)
      end
      context 'Order of the tracking list is 9, after down' do
        let! (:tracking_list) { TrackingList.find_by_row_order(9) }
        before { tracking_list.down }
        subject { TrackingList.order(:id).pluck(:row_order) }
        it { is_expected.to eq([1, 2, 3, 4, 5, 6, 7, 9, 8, 10]) }
      end

      context 'Order of the tracking list is 1, after down' do
        let! (:tracking_list) { TrackingList.order(row_order: :ASC).first }
        before { tracking_list.down }
        subject { TrackingList.order(:id).pluck(:row_order) }
        it { is_expected.to eq([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) }
      end
    end

    context 'When current user only has one tracking list, after down' do
      before do
        user = User.create(name: "tester")
        user.tracking_lists.create(name: "list1")
      end
      let! (:tracking_list) { TrackingList.first }
      before { tracking_list.down }
      subject { TrackingList.find_by_id(tracking_list.id) }
      its(:row_order) do
        is_expected.to eq(1)
      end
    end
  end
end
