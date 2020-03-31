class AddColoumnLabelsUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :labels, :user_id, :integer ,null: false, default: 0
  end
end
