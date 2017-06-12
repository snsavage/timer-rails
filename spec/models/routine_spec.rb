# == Schema Information
#
# Table name: routines
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  link        :string
#  times       :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Routine, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :times }
  it { should validate_presence_of :user }

  it { should validate_numericality_of :times }

  it { should belong_to :user }

  it { should have_db_index :user_id }
end
