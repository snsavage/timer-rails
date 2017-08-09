# == Schema Information
#
# Table name: routines
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text             default(""), not null
#  link        :string           default(""), not null
#  times       :integer          default(1)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  public      :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Routine, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :times }
  it { should validate_presence_of :user }

  it { should validate_numericality_of :times }

  it { should belong_to :user }
  it { should have_many :routine_durations }

  it { should have_db_index :user_id }

  it { should accept_nested_attributes_for(:groups) }

  describe ".total_duration" do
    it "returns 0 with no groups or intervals" do
      routine = create(:routine)

      expect(routine.total_duration).to eq(0)
    end

    it "returns the duration with groups and intervals" do
      routine = create(:routine)
      group = create(:group, routine: routine)
      interval = create(:interval, group: group)

      expect(routine.total_duration).to eq(interval.duration)
    end
  end
end
