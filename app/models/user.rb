class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, allow_blank: true, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book

  def favorite(book)
    favorites.find_or_create_by(book_id: book.id)
  end

  def unfavorite(book)
    favorite = favorites.find_by(book_id: book.id)
    favorite.destroy if favorite
  end

  def favorite?(book)
    favorite_books.include?(book)
  end
end
