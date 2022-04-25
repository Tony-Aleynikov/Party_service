class BookingTimerJob
  include Sidekiq::Job

  def perform(ticket_number)
    ticket          = Ticket.find_by(ticket_number: ticket_number)
    ticket_category = ticket.ticket_category

    if ticket.status == "booked"
      event = Event.find_by(event_date: ticket.event_date)
      event.update(standart_tikets: event.standart_tikets + 1) if ticket_category == "standart"
      event.update(vip_tickets: event.vip_tickets + 1) if ticket_category == "vip"
      ticket.destroy
    end
  end
end
