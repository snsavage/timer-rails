class AddUserIdIndexToRoutines < ActiveRecord::Migration[5.1]
  def change
    add_index :routines, :user_id
  end
end
