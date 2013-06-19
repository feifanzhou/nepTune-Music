class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :status, limit: 16
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
