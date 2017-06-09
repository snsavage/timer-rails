# == Schema Information
#
# Table name: intervals
#
#  id         :integer          not null, primary key
#  name       :string
#  duration   :integer
#  order      :integer
#  repeat_id  :integer
#  routine_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Interval, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :duration }
  it { should validate_presence_of :order }
  it { should validate_presence_of :repeat }
  it { should validate_presence_of :routine }
  it { should validate_presence_of :order }

  it { should validate_numericality_of :duration }
  it { should validate_numericality_of :order }

  it { should belong_to :routine }
  it { should belong_to :repeat }

  it { should have_db_index :repeat_id }
  it { should have_db_index :routine_id }
end
