# == Schema Information
#
# Table name: intervals
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  name       :string
#  order      :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  duration   :integer          default(0)
#

require 'rails_helper'

RSpec.describe Interval, type: :model do
end
