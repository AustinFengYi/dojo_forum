class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name
  mount_uploader :avatar, AvatarUploader

  has_many :posts, dependent: :destroy

  has_many :replies, dependent: :destroy

  has_many :favorites,dependent: :destroy

  has_many :friendships, -> {where status: true}, dependent: :destroy #我想加好友的 (已成為好友）)
  has_many :friends,through: :friendships,source: :friend

  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friend_asks, through: :inverse_friendships, source: :user #想加我好友的 （已成為好友）

  has_many :unconfirm_friendships, -> {where status: false}, class_name: "Friendship", dependent: :destroy
  has_many :unconfirm_friends, through: :unconfirm_friendships, source: :friend #等待邀請回覆(未成為好友)

  has_many :request_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :request_friends, through: :request_friendships, source: :user #想加我好友的 #是否接受邀請 (未成為好友)

  def admin?
    self.role == "admin"
  end

  def friend?(user) #user的好友
    self.friends.include?(user)|| self.friend_asks.include?(user) #||(邏輯運算子):或者
  end

  def unconfirm_friend?(user) #user加別人好友(等待邀請回覆)
    self.unconfirm_friends.include?(user)
  end

  def request_friend?(user)
    self.request_friends.include?(user)
  end

  def all_friends
    friends = self.friends + self.friend_asks
    return friends.uniq #不要重複
  end
end
