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

  scope :sorted_by, -> (sort_option) do
    case sort_option
    when 'end_date'
      order(end_date: :desc)
    else
      order(created_at: :desc, priority: :desc)
    end
  end

  scope :with_label_ids, -> (label_ids) do
    next if label_ids&.reject(&:blank?).blank?
    joins(:labels).where(labels: { id: label_ids })
  end

end
