class TicketBlockController < ApplicationController
  def block
    Faraday.post( "http://ticket_service:3002/ticket_block/block",
                 {ticket_number: params["ticket_number"], password: "123"} )
    render json: {result: "success" }

    rescue
      render json: {result: "service not responding" }
  end
end
