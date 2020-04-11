class CreateLoanApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_applications do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :encrypted_ssn
      t.string :email
      t.string :phone
      t.integer :income
      t.string :income_type
      t.integer :requested_loan_amount
      t.timestamps
    end
  end
end
