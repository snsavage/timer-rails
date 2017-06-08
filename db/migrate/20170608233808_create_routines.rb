class CreateRoutines < ActiveRecord::Migration[5.1]
  def change
    create_table :routines do |t|
      t.string :name
      t.text :description
      t.string :link
      t.integer :times
      t.integer :user_id

      t.timestamps
    end
  end
end
