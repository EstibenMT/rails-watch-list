class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_many :reviews, dependent: :destroy
  has_one_attached :photo
  validates :name, presence: true, uniqueness: true

  validate :upload_is_image

  private

  def upload_is_image
    return if photo && photo.content_type =~ %r{/^image/(jpeg|pjpeg|png|bmp)$/}

    photo.purge
    errors.add(:photo, ': This is not a valid photo')
  end
end
