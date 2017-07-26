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

  def total_duration
    return 0 unless duration = routine_durations.first

    duration.total
  end
end
