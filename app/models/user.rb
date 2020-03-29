class User < ApplicationRecord
  before_destroy :admin_user_exists?
  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks, dependent: :destroy

  validates :name, presence: true,
                   length: { maximum: 30 }
  validates :email, presence: true,
                   length: { maximum: 255},
                   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                   uniqueness: true
  validates :password, presence: true,
                      length: { minimum: 6}

  private
  
  scope :sorted_by, -> do
    joins("LEFT OUTER JOIN tasks ON users.id = tasks.user_id").
    select('users.id, name, email, admin, count(tasks.id) as tasks_count').
    group(:id).order("users.created_at desc")
  end
  
  def admin_user_exists?
    admin_user = User.where(admin: true).count 
    if self.admin? && admin_user == 1
      throw(:abort)
    end
  end
end
