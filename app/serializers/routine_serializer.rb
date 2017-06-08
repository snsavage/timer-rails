class RoutineSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :link, :times, :user_id
end
