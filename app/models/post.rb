class Post < ApplicationRecord
  mount_uploader :image , ImageUploader 
  validates_presence_of :title, :content

  belongs_to :user
  #belongs_to :category
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories, source: :category

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites,source: :user

  has_many :replies, dependent: :destroy

  def count_views
    self.viewed_count += 1
    self.save
  end

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

end
