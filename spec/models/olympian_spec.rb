require 'rails_helper'

RSpec.describe Olympian, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it { should validate_presence_of(:sex) }

    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }

    it { should validate_presence_of(:height) }
    it { should validate_numericality_of(:height) }

    it { should validate_presence_of(:weight) }
    it { should validate_numericality_of(:weight) }
  end
end
