class AddDefaultsToRoutines < ActiveRecord::Migration[5.1]
  def change
    change_column_default :routines, :description, {from: nil, to: ""}
    change_column_default :routines, :link, {from: nil, to: ""}
  end
end
