# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
  end

  describe 'enums' do
    it { should define_enum_for(:size).with_values({ small: 0, medium: 1, large: 2 }) }
  end
end
