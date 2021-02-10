class Task < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  belongs_to :user

  validates :title, presence: true,
                    length: { maximum: 30 }
  validates :content , presence: true,
                       length: { maximum: 255 }
  validates :end_date, presence: true,
                       format: { with: /\d{4}-\d{2}-\d{2}/ }


  scope :filtered_by, -> (*filter_params) do
    return all if filter_params.blank?

    allowable_scope_list = %w[
      with_user_id
      with_title
      with_status
      with_priority
      with_label_ids
      sorted_by
    ]
    return all if (allowable_scope_list | filter_params.keys).size != allowable_scope_list.size

    filter_params.inject(self) do |task, param|
      next unless allowable_scope_list.include?(param[0])
      task.send(param[0], param[1])
    end
  end

  scope :with_user_id, -> (user_id) do
    next if user_id.blank?
    where(user_id: user_id)
  end

  scope :with_title, -> (title) do
    next if title.blank?
    where("title Like ?", "%#{title}%")
  end

  scope :with_status, -> (status) do
    next if status.blank? || status.include?('全て')
    where(status: status) 
  end

  scope :with_priority, -> (priority) do
    next if priority.blank?
    where(priority: priority) 
  end

  scope :with_label_ids, -> (label_ids) do
    next if label_ids&.reject(&:blank?).blank?
    joins(:labels).where(labels: { id: label_ids })
  end

  scope :sorted_by, -> (sort_option) do
    case sort_option
    when 'end_date'
      order(end_date: :desc)
    else
      order(created_at: :desc, priority: :desc)
    end
  end

end
