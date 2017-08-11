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

class RoutineSerializer < ActiveModel::Serializer
  has_many :groups
  has_many :intervals, through: :groups

  attributes :id,
             :name,
             :description,
             :link,
             :times,
             :user_id,
             :public,
             :duration

  def duration
    @object.total_duration
  end
end
