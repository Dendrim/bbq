class Photo < ApplicationRecord
  scope :persisted, -> { where 'id IS NOT NULL' }

  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
end
