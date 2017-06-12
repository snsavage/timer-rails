class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :routine_id, index: true
      t.integer :order, default: 1
      t.integer :times, default: 1

      t.timestamps
    end
  end
end
