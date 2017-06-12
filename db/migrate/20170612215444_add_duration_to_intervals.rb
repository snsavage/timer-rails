class AddDurationToIntervals < ActiveRecord::Migration[5.1]
  def change
    add_column :intervals, :duration, :integer, default: 0
  end
end
