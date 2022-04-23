class TicketBlockController < ApplicationController
  def block
    Faraday.post(ENV["TICKET_BUYING_SERVICE_URL"], {ticket_number: params["ticket_number"], password: "123"})
    render json: {result: "success" }

    rescue
      render json: {result: "service not responding" }
  end
end
