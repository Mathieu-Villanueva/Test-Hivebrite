class User < ApplicationRecord
  has_many :custom_attributes, as: :customizable, dependent: :destroy

  validates :email, presence: true
end
