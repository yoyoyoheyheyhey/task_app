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

  private

  scope :with_user_id, -> (user_id) do
    next if user_id.nil?
    where(user_id: user_id)
  end

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

  scope :with_label_name, -> (label_id) do
    next if label_id.nil?
    label_flg = false
    labels = []
    # label_id.each_with_index do |label, i|
    label_id.each do |label|
      unless label.blank?
        label_flg = true

        #該当するラベルは全て取得する
        labels.push(label) 

        # 該当するラベルに全て一致するタスクのみ取得
        # unless label_id[i+1].nil? && label_id[i+1] == "" 
        #   labels.push("#{label} AND labellings.label_id =") 
        # else
        #   labels.push(label) 
        # end

      end
    end

    next unless label_flg
    # 該当するラベルは全て取得する
    joins(:labellings).where("labellings.label_id IN ( ? )", labels) 

    # 該当するラベルに全て一致するタスクを取得する場合の処理
    # labels = labels.join(',')
    # labels = labels.gsub(',', ' ')
    # labels = labels.gsub("'",' ')
    # labels.slice!(-25..-1)
    # joins(:labellings).where("labellings.label_id = #{labels} ") 
    
  end
end
