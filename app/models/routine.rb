# == Schema Information
#
# Table name: routines
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  link        :string
#  times       :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Routine < ApplicationRecord
  belongs_to :user

  validates :name, :times, :user, presence: true
  validates :times, numericality: { only_integer: true, greater_than: 0 }
end
