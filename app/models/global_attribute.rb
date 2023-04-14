class GlobalAttribute < ApplicationRecord
  has_many :custom_attributes, as: :customizable

  validates :name, presence: true

  scope :active, -> { where(active: true) }
  scope :required, -> { where(required: true) }
end
