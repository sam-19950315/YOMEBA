class AddLogToReadBookLog < ActiveRecord::Migration[6.0]
  def change
    add_column :read_book_logs, :log, :date
  end
end
