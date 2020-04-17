class CreateLoanApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_applications do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :encrypted_ssn
      t.string :encrypted_ssn_iv
      t.string :email
      t.string :phone
      t.float :income
      t.string :income_type
      t.float :requested_loan_amount
      t.integer :address_id
      t.string :status
      t.timestamps
    end
  end
end
