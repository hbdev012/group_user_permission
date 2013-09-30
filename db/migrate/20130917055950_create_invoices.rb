class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :invoice_date_request
      t.datetime :date_of_payment_receipt
      t.string :invoice_no
      t.string :client_name
      t.string :request_currency
      t.float :request_currency_rate
      t.float :request_payment_amount
      t.float :request_payment_amount_usd
      t.float :received_amount_currency
      t.float :received_currency_rate
      t.float :received_amount
      t.float :received_amount_usd
      t.float :transaction_cost
      t.string :bank
      t.string :mode_of_payment
      t.string :client_status
      t.string :work_status
      t.string :payment_type
      t.string :project_code
      t.integer :created_by
      t.integer :udpated_by

      t.timestamps
    end
  end
end
