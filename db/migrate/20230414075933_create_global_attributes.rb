class CreateGlobalAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :global_attributes do |t|
      t.string :name
      t.boolean :required
      t.boolean :active

      t.timestamps
    end
  end
end
