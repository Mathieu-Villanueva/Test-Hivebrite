class GlobalAttribute < ApplicationRecord
  has_many :custom_attributes, as: :customizable

  validates :name, presence: true
end
