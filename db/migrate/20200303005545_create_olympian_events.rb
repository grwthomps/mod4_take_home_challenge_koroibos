class CreateOlympianEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :olympian_events do |t|
      t.references :olympian, foreign_key: true
      t.references :event, foreign_key: true
      t.string :medal

      t.timestamps
    end
  end
end
