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

class Routine < ApplicationRecord
  belongs_to :user
  has_many :groups
  has_many :intervals, through: :groups
  has_many :routine_durations

  validates :name, :times, :user, presence: true
  validates :times, numericality: { only_integer: true, greater_than: 0 }

  accepts_nested_attributes_for :groups

  def total_duration
    duration = routine_durations.first

    duration ? duration.total : 0
  end

  def groups_attributes=(group_attributes)
    update_ids = group_attributes.map { |x| x["id"] }
    group_ids = self.groups.pluck(:id)

    Group.delete(group_ids - update_ids)

    group_attributes.each do |attr|
      group = Group.find_or_initialize_by(id: attr["id"])
      intervals = attr["intervals_attributes"]

      group.order = attr["order"]
      group.times = attr["times"]
      group.intervals_attributes = intervals if intervals

      self.groups << group
    end
  end
end
