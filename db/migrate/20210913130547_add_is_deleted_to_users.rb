class AddIsDeletedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :is_deleted, :boolean,             default: false
  end
end
