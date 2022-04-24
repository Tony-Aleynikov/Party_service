class BookingTimerJob
  include Sidekiq::Job

  def perform(ticket_number)
    ticket = Ticket.find_by(ticket_number: ticket_number)
    if ticket.status == "booked"
      ticket.destroy
    end
  end
end
