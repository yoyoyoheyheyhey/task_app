class Task < ApplicationRecord
  scope :with_title, -> (title) do
    next if title.blank?
    where("title Like ?", "%#{title}%")
  end

  scope :with_status, -> (status) do
    next if status.nil? || status.include?('全て')
      where(status: status) 
  end

  scope :sorted_by, -> (sort_option) do
    if sort_option.nil?
      order(priority: :desc).order(created_at: :desc)
    elsif sort_option.include?('end_date')
      order(end_date: :desc)
    else
      order(priority: :desc).order(created_at: :desc)
    end
  end


  validates :title, presence: true,
                    length: { maximum: 30 }
  validates :content , presence: true,
                       length: { maximum: 255 }
end
