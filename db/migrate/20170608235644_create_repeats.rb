class CreateRepeats < ActiveRecord::Migration[5.1]
  def change
    create_table :repeats do |t|
      t.integer :times

      t.timestamps
    end
  end
end
