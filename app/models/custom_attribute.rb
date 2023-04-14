class CustomAttribute < ApplicationRecord
  belongs_to :customizable, polymorphic: true
  belongs_to :global_attribute, optional: true

  validates :customizable_type, inclusion: { in: %w(User Event) }
  validates :name, presence: true
end
