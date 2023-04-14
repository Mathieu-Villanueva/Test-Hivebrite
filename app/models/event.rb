class Event < ApplicationRecord
  has_many :custom_attributes, as: :customizable, dependent: :destroy

  validates :name, presence: true
end
