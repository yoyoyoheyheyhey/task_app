class Task < ApplicationRecord
  scope :latest, -> (number = 20){order(created_at: :desc).limit(number)}
  validates :title, presence: true,
                    length: { maximum: 30 }
  validates :content , presence: true,
                       length: { maximum: 255 }
end
