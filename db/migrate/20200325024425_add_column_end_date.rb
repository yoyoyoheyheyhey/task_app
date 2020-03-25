class AddColumnEndDate < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :end_date, :string, null: false, default: '99991231'
  end
end
