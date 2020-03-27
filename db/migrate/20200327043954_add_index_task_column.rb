class AddIndexTaskColumn < ActiveRecord::Migration[5.2]
  def up
    add_index :tasks, :title
    add_index :tasks, :end_date
    add_index :tasks, :status
    add_index :tasks, :priority
  end

  def down
    remove_index :tasks, :title
    remove_index :tasks, :end_date
    remove_index :tasks, :status
    remove_index :tasks, :priority
  end
end
