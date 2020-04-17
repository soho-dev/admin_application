class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.text :street
      t.text :unit_number
      t.text :city
      t.string :state
      t.string :zip
      t.string :county
      t.timestamps
    end
  end
end
