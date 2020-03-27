class AddColumnEndDate < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :end_date, :datetime, null: false, default: '9999-12-31 00:00:00'
  end
end
