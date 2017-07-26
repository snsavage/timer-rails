class CreateRoutineDurations < ActiveRecord::Migration[5.1]
  def change
    create_view :routine_durations
  end
end
