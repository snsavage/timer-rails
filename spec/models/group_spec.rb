# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  order      :integer          default(1)
#  times      :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should accept_nested_attributes_for(:intervals) }

  describe ".intervals_attributes" do
    it "prevents uuids.to_i from colliding with existing ids" do
      @user = create(:user)
      routine = create(:routine, user: @user)
      group = create(:group, routine: routine)
      interval = create(:interval, group: group)
      attr = attributes_for(:interval, group: group)

      interval_attributes = [
        {
          "id": interval.id,
          "name": interval.name,
          "duration": interval.duration
        },
        {
          "id": "#{interval.id.to_s}-uuid",
          "name": attr[:name],
          "duration": attr[:duration]
        }
      ]

      group.intervals_attributes = interval_attributes

      expect(group.intervals.count).to eq 2
    end
  end
end
