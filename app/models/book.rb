class Book < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :trades, dependent: :delete_all
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true

  scope :listed, -> {where(status: true)}
end
