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
  has_many :intervals
end
