class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres, id: :bigint do |t|
      t.string :genre_name,                 null: :false
      t.integer :user_id,                   null: :false
      t.timestamps
    end
  end
end
