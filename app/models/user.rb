class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  scope :active_users, -> { where(active: true) }
  scope :inactive_users, -> { where(active: false) }
  has_many :conge_demandes,dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nom, presence: true
  validates :prenom, presence: true
end
