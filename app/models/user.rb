class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  scope :sorted_by, -> do
    # joins(:tasks).
    joins("LEFT OUTER JOIN tasks ON users.id = tasks.id").
    select('users.id, name, email, admin, count(tasks.id) as tasks_count').
    group(:id).order("users.created_at desc")
  end
  
  before_validation { email.downcase! }
  validates :name, presence: true,
                   length: { maximum: 30 }
  validates :email, presence: true,
                   length: { maximum: 255},
                   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                   uniqueness: true
  validates :password, presence: true,
                      length: { minimum: 6}
end
