# == Schema Information
#
# Table name: routine_durations
#
#  routine_id :integer
#  total      :integer
#

class RoutineDuration < ApplicationRecord
  belongs_to :routine
end
