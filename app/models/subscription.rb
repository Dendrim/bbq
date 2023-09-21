class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email,
            presence: true,
            format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
            unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :forbid_anonymous_sub_with_existing_email, on: :create

  validate :forbid_event_creator_to_subscribe, on: :create


  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def forbid_anonymous_sub_with_existing_email
    if user.blank? && User.where(email: self&.user&.email || user_email).exists?
      errors.add(
        :email,
        I18n.t('activerecord.errors.cant_sub_registered_users')
      )
    end
  end

  def forbid_event_creator_to_subscribe
    if event.user == user
      errors.add(
        :user_id,
        I18n.t('activerecord.errors.cant_subscribe_to_your_own_event')
      )
    end
  end
end
