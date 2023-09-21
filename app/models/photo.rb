class Photo < ApplicationRecord
  scope :persisted, -> { where 'id IS NOT NULL' }

  belongs_to :event
  belongs_to :user

  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
end
