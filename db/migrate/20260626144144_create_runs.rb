class CreateRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :runs do |t|
      t.date :date
      t.float :distance
      t.integer :duration
      t.integer :heart_rate
      t.integer :cadence
      t.integer :elevation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
