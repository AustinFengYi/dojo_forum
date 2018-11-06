class Post < ApplicationRecord
  mount_uploader :image , ImageUploader 
  validates_presence_of :title, :content

  belongs_to :user
  belongs_to :category

  has_many :replies, dependent: :destroy
end
