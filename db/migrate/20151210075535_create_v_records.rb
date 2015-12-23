class CreateVRecords < ActiveRecord::Migration
  def change
    create_table :v_records do |t|
      t.integer :level
      t.integer :count, default: 0
      t.integer :group

      t.timestamps null: false
    end
  end
end
