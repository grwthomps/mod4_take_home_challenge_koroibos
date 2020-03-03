require 'rails_helper'

RSpec.describe OlympianEvent, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:medal) }
  end
end
