class TicketSellingService

  def self.event_search(params)
    if Event.find_by(event_date: params["event_date"]) == nil #если мероприятия нет, то создать мероприятие
      Event.create(event_date: params["event_date"], vip_tickets: 50, standart_tikets: 150, event_name: "Event - #{params["event_date"]} ")
    end
  end

  def self.search_free_tickets(params)
    if params["ticket_category"] == "standart"
      free_tickets = Event.find_by(event_date: params["event_date"]).standart_tikets > 0
    else
      free_tickets = Event.find_by(event_date: params["event_date"]).vip_tickets > 0
    end

    if free_tickets == false
      return render json: { result: "Билеты распроданы"}
    end
  end

  def self.create_ticket(params, ticket_number, booking_number)
    Ticket.create(ticket_number: ticket_number,
    event_date: params["event_date"],
    ticket_category: params["ticket_category"],
    booking_number: booking_number,
    status: "booked")
  end

  def self.update_number_free_tickets(params)
    if params["ticket_category"] == "standart"
      event = Event.find_by(event_date: params["event_date"])
      event.update(standart_tikets: event.standart_tikets - 1)
    else
      event = Event.find_by(event_date: params["event_date"])
      event.update(vip_tickets: event.vip_tickets - 1)
    end
  end

  def self.calculate_price(params)
    ticket_price = if params["ticket_category"] == "standart"
      standart_tickets = Event.find_by(event_date: params["event_date"]).standart_tikets
      1000 + (150 - standart_tickets)/15 * 100
     else
      vip_tickets = Event.find_by(event_date: params["event_date"]).vip_tickets
      2000 + (50 - vip_tickets)/5 * 200
     end
  end

end
