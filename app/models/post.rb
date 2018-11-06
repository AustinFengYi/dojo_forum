class Post < ApplicationRecord
  mount_uploader :image 
  validates_presence_of :title, :content

  belongs_to :user
end
