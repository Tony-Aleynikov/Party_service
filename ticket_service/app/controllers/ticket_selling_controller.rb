class TicketSellingController < ApplicationController
  def reservation
    #params {event_date: "04/24/2022", ticket_category: "vip"}
    ReservationService.event_search(params)        #проверка, есть ли мероприятие с такой датой
    ReservationService.search_free_tickets(params) #проверка, остались ли билеты на это мероприятие

    ticket_number  = Time.current.to_i.to_s
    booking_number = Time.current.to_i.to_s

    ReservationService.create_ticket(params, ticket_number, booking_number) #создать билет
    ReservationService.update_number_free_tickets(params)     #обновить количество свободных билетов
    ReservationService.booking_timer(ticket_number)           #отправить запрос во 2 сервис о брони
    ticket_price = ReservationService.calculate_price(params) #посчитать стоимость билета

    render json: {booking_number: booking_number, ticket_price: ticket_price } #рендер стоимости и номера брони
  end

  def cancel_reservation
    ticket = Ticket.find_by(booking_number: params["booking_number"])
    CancelReservationService.update_number_free_tickets(ticket)
    ticket.destroy

    render json: { result: "Бронь отменена" }
  end

  def buying_ticket #params { full_name, document_type, document_number, booking_number}
    user = User.find_by(full_name:       params["full_name"],
                        document_type:   params["document_type"],
                        document_number: params["document_number"])

    if user == nil
      user = User.create(full_name: params["full_name"],
                         document_type: ["document_type"],
                         document_number["document_number"] )
    end

    ticket = Ticket.find_by(booking_number: params["booking_number"])

    if user.tickets.find_by(event_date: ticket.event_date)
      return render json: { result: "У вас уже есть билет на сегодняшнее мероприятие" }
    end

    ticket.update(status: "bought")
    user.tickets << ticket

    render json: {result: "Билет куплен"}
  end

end
