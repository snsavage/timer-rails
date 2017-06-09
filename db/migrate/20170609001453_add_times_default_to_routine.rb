class AddTimesDefaultToRoutine < ActiveRecord::Migration[5.1]
  def change
    change_column_null :routines, :times, default: 1
  end
end
