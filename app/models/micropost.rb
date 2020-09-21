class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 50}
  validates :liveplace, presence: true, length: { maximum: 50}
  
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'micropost_id' , dependent: :destroy
  has_many :favoriters, through: :reverses_of_favorite, source: :user

  def self.search(search) #ここでのself.はMicropost.を意味する
    if search
      where(['content LIKE ?', "%#{search}%"]) #検索とcontentの部分一致を表示。Micropost.は省略。
    else
      all #全て表示。Micropost.は省略。
    end
  end

end
