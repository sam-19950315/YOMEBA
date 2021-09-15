class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books, id: :bigint do |t|

      t.string :book_subject,                                  null: :false
      t.integer :user_id,                                      null: :false
      t.integer :genre_id,                                     null: :false
      t.timestamps
    end
  end
end
