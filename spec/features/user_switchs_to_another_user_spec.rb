# frozen_string_literal: true

require 'rails_helper'

describe 'User switches to another user' do
  before do
    create_list(:user, 3)
    visit root_path
  end

  it 'expect to see the first user name' do
    expect(page).to have_text("現在使用者為： #{User.first.name}")
  end

  it 'expect to change current user' do
    select User.second.name, from: '切換使用者'
    expect(page).to have_text("現在使用者為： #{User.second.name}")
  end
end
