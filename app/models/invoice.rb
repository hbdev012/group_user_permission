class Invoice < ActiveRecord::Base
  attr_accessible :bank, :client_name, :client_status, :created_by, :date_of_payment_receipt, :invoice_date_request, :invoice_no, :mode_of_payment, :payment_type, :project_code, :received_amount, :received_amount_currency, :received_amount_usd, :received_currency_rate, :request_currency, :request_currency_rate, :request_payment_amount, :request_payment_amount_usd, :transaction_cost, :udpated_by, :work_status
  has_paper_trail 

  def self.create_last_invoice(params)
  	last = Invoice.last
    if last.present? && last.invoice_no.present?  
      last_invoice_no = last.invoice_no.split(Global::INVOICE_STRING)[1].to_i + 1 
    else 
      last_invoice_no = 1  
    end
  	last_invoice_no = "#{Global::INVOICE_STRING}#{Global.formatnumber4(last_invoice_no.to_i)}"
  	invoice = self.new(params)
    invoice.invoice_no = last_invoice_no
  	invoice.save
    return invoice
  end


end
