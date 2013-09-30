class Global
	PERPAGE = 10
	INVOICE_STRING = "INV"

	def self.formatnumber4(nbr)
    return "0000" if nbr.nil? || nbr.blank?
    return "000" + nbr.to_s if nbr.to_i<10
    return "00" + nbr.to_s if nbr.to_i<100
    return "0" + nbr.to_s if nbr.to_i<1000
    return nbr.to_s
  end
end