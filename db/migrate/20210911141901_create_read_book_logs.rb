class CreateReadBookLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :read_book_logs do |t|

      t.date :read_day,                      null: :false
      t.integer :user_id,                    null: :false
      t.integer :book_id,                    null: :false
      t.integer :genre_id,                   null: :false
      t.timestamps
    end
  end
end
