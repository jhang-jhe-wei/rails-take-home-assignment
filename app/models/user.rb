# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tracking_lists, dependent: :destroy
end
