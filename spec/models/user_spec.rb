# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_db_index(:email) }

  describe '#jwt_payload' do
    it 'returns a hash with user\' id, email, and first_name' do
      user = create(:user)
      payload = {
        id: user.id,
        email: user.email,
        first_name: user.first_name
      }

      expect(user.jwt_payload).to eq(payload)
    end
  end
end
