class CreateCustomAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :custom_attributes do |t|
      t.string :name
      t.string :value
      t.boolean :required, default: false

      t.timestamps
    end
  end
end
