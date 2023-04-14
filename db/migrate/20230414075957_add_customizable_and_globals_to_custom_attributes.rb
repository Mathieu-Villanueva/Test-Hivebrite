class AddCustomizableAndGlobalsToCustomAttributes < ActiveRecord::Migration[6.1]
  def change
    add_reference :custom_attributes, :customizable, polymorphic: true
    add_reference :custom_attributes, :global_attribute, foreign_key: { to_table: :global_attributes }
  end
end
