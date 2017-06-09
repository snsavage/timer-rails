class AddIndexToInterval < ActiveRecord::Migration[5.1]
  def change
    add_index :intervals, :routine_id
    add_index :intervals, :repeat_id
  end
end
