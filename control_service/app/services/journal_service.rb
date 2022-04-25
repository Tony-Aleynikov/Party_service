class JournalService

  def self.sorting(params)
    entries = Entry.all
    entries = entries.where( ticket_number:   params["ticket_number"])   if params["ticket_number"]
    entries = entries.where( ticket_category: params["ticket_category"]) if params["ticket_category"]
    entries = entries.where( full_name:       params["full_name"])       if params["full_name"]
    entries = entries.where( event_date:      params["event_date"])      if params["event_date"]
    entries = entries.where( result:          params["result"])          if params["result"]
    entries = entries.where( status:          params["status"])          if params["status"]
    entries = entries.where( document_type:   params["document_type"])   if params["document_type"]
    entries = entries.where( document_number: params["document_number"]) if params["document_number"]
    entries = entries.where( event_name:      params["event_name"])      if params["event_name"]
    entries = entries.where( created_at:      params["created_at"])      if params["created_at"]
    entries
  end

end
