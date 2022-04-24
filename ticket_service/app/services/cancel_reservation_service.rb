class CancelReservationService

  def self.update_number_free_tickets(ticket)
    ticket_category = ticket.ticket_category
    event_date      = ticket.event_date

    if ticket_category == "standart"
      event = Event.find_by(event_date: event_date)
      event.update(standart_tikets: event.standart_tikets + 1)
    else
      event = Event.find_by(event_date: event_date)
      event.update(vip_tickets: event.vip_tickets + 1)
    end
  end

end
