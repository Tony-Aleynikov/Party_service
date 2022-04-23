class EntryService

  def self.get_data(params)
    response = Faraday.get(ENV["TICKET_BUYING_SERVICE_URL"], {ticket_number: params["ticket_number"], password: 123})
    transform_data(response)
  end

  def self.add_entry(ticket_information, result, status)

    Entry.create(ticket_number: ticket_information["ticket_number"],
                 ticket_category: ticket_information["ticket_category"] ,
                 full_name: ticket_information["full_name"]
                 event_date: ticket_information["event_date"],
                 result: result,
                 status: status,
                 document_type: ticket_information["document_type"],
                 document_number: ticket_information["document_number"],
                 event_name: ticket_information ["event_name"] )
  end

  private

  def self.transform_data(response)
    JSON.parse(response.body)
  end
end
