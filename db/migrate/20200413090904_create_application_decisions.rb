class CreateApplicationDecisions < ActiveRecord::Migration[5.1]
  def change
    create_table :application_decisions do |t|
      t.integer :loan_application_id
      t.json :encrypted_request
      t.string :encrypted_request_iv
      t.json :encrypted_response
      t.string :encrypted_response_iv
      t.string :decision

      t.timestamps
    end
  end
end
