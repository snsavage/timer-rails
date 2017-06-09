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

class Interval < ApplicationRecord
  belongs_to :repeat
  belongs_to :routine

  validates :name, :duration, :order, :repeat, :routine, presence: true

  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  validates :order, numericality: { only_integer: true, greater_than: 0 }

  validates_associated :routine

  validates :order, uniqueness: { scope: :routine }

end
