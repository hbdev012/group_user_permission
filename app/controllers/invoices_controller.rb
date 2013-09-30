class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.paginate(:page => params[:page], :per_page => Global::PERPAGE)
  end


  def new
    @invoice = Invoice.new  
  end

  def create
    @invoice = Invoice.create_last_invoice(params[:invoice])
    if @invoice.present?
      flash[:notice] = "Invoice has been created successfully"
      redirect_to invoices_path
    else  
      flash[:error] = "Invoice is not created. Please fill required fields"
      render :action => "new"
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      flash[:notice] = "Invoice has been updated"
      redirect_to invoices_path
    else  
      flash[:error] = "Invoice is not updated"
      render :action => "edit"
    end
  end

  def show
    @invoice = Invoice.find(params[:id])      
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end

  def history
      @histories = Version.select("versions.*,invoices.invoice_no ,concat(users.first_name,' ',users.last_name) as user_name").where("item_type = 'Invoice'").joins("LEFT JOIN users ON users.id = versions.whodunnit").joins("LEFT JOIN invoices ON invoices.id = versions.item_id").paginate(:page => params[:page], :per_page => Global::PERPAGE)
  end

end
