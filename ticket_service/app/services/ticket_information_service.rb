class TicketInformationService

  def self.data_search(ticket_number)
    ticket = Ticket.find_by(ticket_number: ticket_number)
    user   = ticket.users.first
    event  = Event.find_by(event_date: ticket.event_date)

    { ticket_number:   ticket.ticket_number,
      ticket_category: ticket.ticket_category,
      full_name:       user.full_name,
      event_date:      ticket.event_date,
      document_type:   user.document_type,
      document_number: user.document_number,
      event_name:      event.event_name,
      status:          ticket.status }
  end

end
