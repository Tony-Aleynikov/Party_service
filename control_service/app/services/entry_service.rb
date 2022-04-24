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

  def self.standart_check(ticket_information, ticket_entry)
    check(ticket_information, ticket_entry)
  end

  def self.vip_check(ticket_information, ticket_entry)
    if ticket_information["ticket_category"] == "standart"
      EntryService.add_entry(ticket_information, false, "outside")
      return render json: {result: false }
    end
    check(ticket_information, ticket_entry)
  end

  def check(ticket_information, ticket_entry)
    if ticket_information.status == "block" || ticket_entry&.status == "inside"
      EntryService.add_entry(ticket_information, false, "inside")
      return render json: {result: false }
    end

    if ticket_information.event_date != Time.current.strftime("%m/%d/%Y")
      EntryService.add_entry(ticket_information, false, "outside")
      return render json: {result: false }
    end
  end

  private

  def self.transform_data(response)
    JSON.parse(response.body)
  end
end
