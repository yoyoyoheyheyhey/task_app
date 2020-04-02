class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings
  validates :name, presence: true

  scope :with_label_name, -> (current_user) do
    next if label_name.blank?
    current_user.tasks.
    joins(:labellings)
  end
#     Label.where(name: label_name).
#     where(user_id: 0).
#     or(Label.where(user_id: current_user_id))

#     Label.where(name: 'hoge').
#     where(user_id: 0).
#     or(Label.where(user_id: 403))
# current_user.tasks.joins(:labellings).or(Label.where(user_id: 0))

# current_user.tasks.
# joins(:labellings)
# select("labellings.label_id").
# joins("LEFT OUTER JOIN labels ON labellings.id = labels.id").
# where(user_id == 0)
# or(Label.where(user_id: 0))

# SELECT  labellings.label_id FROM "tasks" LEFT OUTER JOIN labellings ON tasks.id = labellings.id LEFT OUTER JOIN labels ON labellings.id = labels.id WHERE "tasks"."user_id" = $1 LIMIT $2


# current_user.tasks.with_label_name(current_user)
end