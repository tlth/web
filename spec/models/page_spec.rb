require 'rails_helper'

RSpec.describe Page, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:page)).to be_valid
  end

  describe 'validates' do
    it 'slug only lowercase' do
      page = build_stubbed(:page)
      expect(page).to allow_value('slug-slug-123').for(:slug)
      expect(page).to_not allow_value('slug_SLUG123').for(:slug)
    end
  end
end

