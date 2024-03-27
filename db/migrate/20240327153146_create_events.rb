class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :date_and_time
      t.integer :total_tickets
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
