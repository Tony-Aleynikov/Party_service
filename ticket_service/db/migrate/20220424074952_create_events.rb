class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_date
      t.integer :vip_tickets
      t.integer :standart_tikets
      t.string :event_name

      t.timestamps
    end
  end
end
