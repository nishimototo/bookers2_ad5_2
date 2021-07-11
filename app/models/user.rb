class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attachment :profile_image
  validates :name, uniqueness: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    passive_relationships.where(following_id: user.id).exists?
  end

  def self.looks(word, search)
    if search == "perfect_match"
      Users.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      Users.where("name LIKE?", "#{word}%")
    elsif search == "backword_match"
      Users.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      Users.where("name LIKE?", "%#{word}%")
    else
      Users.all
    end
  end
end
