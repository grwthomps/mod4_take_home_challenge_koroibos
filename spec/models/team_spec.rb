require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:country) }
    it { should validate_uniqueness_of(:country) }
  end
end
