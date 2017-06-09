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

require 'rails_helper'

RSpec.describe Interval, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
