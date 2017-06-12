class CreateIntervals < ActiveRecord::Migration[5.1]
  def change
    create_table :intervals do |t|
      t.integer :group_id, index: true
      t.string :name
      t.integer :order, default: 1

      t.timestamps
    end
  end
end
