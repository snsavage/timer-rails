class AddCorrectTimesDefaultToRoutine < ActiveRecord::Migration[5.1]
  def change
    change_column_default :routines, :times, { from: nil, to: 1 }
  end
end
