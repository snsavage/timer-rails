class CreateIntervals < ActiveRecord::Migration[5.1]
  def change
    create_table :intervals do |t|
      t.string :name
      t.integer :duration
      t.integer :order
      t.integer :repeat_id
      t.integer :routine_id

      t.timestamps
    end
  end
end
