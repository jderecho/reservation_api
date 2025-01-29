require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { should have_many(:reservations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end
