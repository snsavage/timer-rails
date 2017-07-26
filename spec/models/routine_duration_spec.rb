# == Schema Information
#
# Table name: routine_durations
#
#  routine_id :integer
#  total      :integer
#

require 'rails_helper'

RSpec.describe RoutineDuration, type: :model do
  it { should belong_to :routine }

  describe ".total" do
    it "sums routines with single groups" do
      routine, duration = routine_setup

      expect(routine.total_duration).to eq(duration)
    end

    it "sums routines with multiple groups" do
      routine, duration = routine_setup(number_of_groups: 2)

      expect(routine.total_duration).to eq(duration)
    end

    it "sums routines with single groups with multiple times" do
      routine, duration = routine_setup(group_times: 2)

      expect(routine.total_duration).to eq(duration)
    end

    it "sums routines with multiple intervals" do
      routine, duration = routine_setup(number_of_intervals: 2)

      expect(routine.total_duration).to eq(duration)
    end

    it "sums complex routines" do
      routine, duration = routine_setup(
        routine_times: 10,
        number_of_groups: 10,
        group_times: 10,
        number_of_intervals: 10,
        interval_duration: 20
      )
    end
  end
end

def routine_setup(routine_times: 1,
                  number_of_groups: 1,
                  group_times: 1,
                  number_of_intervals: 1,
                  interval_duration: 10)

  routine = create(:routine, times: routine_times)
  create_list(:group, number_of_groups, routine: routine, times: group_times)
  routine.groups.each do |group|
    create_list(
      :interval, number_of_intervals, group: group, duration: interval_duration
    )
  end

  duration = routine_times *
    number_of_groups *
    group_times *
    number_of_intervals *
    interval_duration

  return routine, duration
end
