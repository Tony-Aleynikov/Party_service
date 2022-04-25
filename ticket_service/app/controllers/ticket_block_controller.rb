class TicketBlockController < ApplicationController
  def block
    Ticket.find_by(ticket_number: params["ticket_number"]).update(status: "blocked")
    render json: {result: "Билет заблокирован"}
  end
end
