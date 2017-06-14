class AddPublicToRoutines < ActiveRecord::Migration[5.1]
  def change
    add_column :routines, :public, :boolean, default: false
  end
end
