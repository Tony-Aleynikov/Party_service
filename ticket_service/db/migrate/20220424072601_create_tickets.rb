class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :ticket_number
      t.string :event_date
      t.integer :ticket_category
      t.string :booking_number

      t.timestamps
    end
  end
end
