class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :ticket_number
      t.integer :ticket_category
      t.string :full_name
      t.string :event_date
      t.boolean :result
      t.integer :status
      t.integer :document_type
      t.string :document_number
      t.string :event_name

      t.timestamps
    end
  end
end
