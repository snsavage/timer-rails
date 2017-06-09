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
end
