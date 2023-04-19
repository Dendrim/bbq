class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create

  def set_name
    self.name = "Товарищ №#{rand(777)}" if self.name.blank?
  end
end
