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

class RoutineSerializer < ActiveModel::Serializer
  has_many :groups
  has_many :intervals, through: :groups

  attributes :id, :name, :description, :link, :times, :user_id
end
