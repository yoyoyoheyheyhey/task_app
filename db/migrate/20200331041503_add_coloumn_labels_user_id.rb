class AddColoumnLabelsUserId < ActiveRecord::Migration[5.2]
  def change
    add_reference :labels, :user ,null: false, default: 0
  end
end
