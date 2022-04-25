class TicketInformationController < ApplicationController
  def ticket #params {ticket_number: params["ticket_number"], password: 123}
    if params["password"] != 123
      data = TicketInformationService.data_search(params["ticket_number"])
      render json: data
    else
      render json: { result: "Отказано в доступе"}
    end
  end
end
