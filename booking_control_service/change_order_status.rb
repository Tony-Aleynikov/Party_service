require 'sidekiq'
include Sidekiq::Worker

class BookingControlService

  def change_status_order(ticket_information) #=> { ticket_number: <ticket number>, booking_time: <time> }
    time = ticket_information["booking_time"] + 300
    perform_in(time,ticket_information)
  end

  def perform
    Faraday.get("url", { ticket_number: ticket_information["ticket_number"]}, password: "123")
  end
end
