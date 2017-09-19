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

class Group < ApplicationRecord
  belongs_to :routine
  has_many :intervals, dependent: :destroy

  accepts_nested_attributes_for :intervals

  def intervals_attributes=(interval_attributes)
    interval_attributes.map! { |x| x.stringify_keys }
    update_ids = interval_attributes.map { |x| x["id"] }
    interval_ids = self.intervals.pluck(:id)

    Interval.delete(interval_ids - update_ids)

    interval_attributes.each do |attr|
      attr["id"] = nil if attr["id"].to_s.match(/[A-Za-z\-]+/)

      interval = Interval.find_or_initialize_by(id: attr["id"])
      interval.name = attr["name"]
      interval.order = attr["order"]
      interval.duration = attr["duration"]
      self.intervals << interval
    end
  end
end
