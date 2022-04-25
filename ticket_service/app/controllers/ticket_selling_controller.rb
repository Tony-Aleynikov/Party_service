class TicketSellingController < ApplicationController

  def reservation #params {event_date: "04/24/2022", ticket_category: "vip"}
    ReservationService.event_search(params)                                    #проверка, есть ли мероприятие с такой датой
    ReservationService.search_free_tickets(params)                             #проверка, остались ли билеты на это мероприятие

    ticket_number  = Time.current.to_i.to_s
    booking_number = Time.current.to_i.to_s

    ReservationService.create_ticket(params, ticket_number, booking_number)    #создать билет
    ReservationService.update_number_free_tickets(params)                      #обновить количество свободных билетов
    BookingTimerJob.perform_in(5.minutes, ticket_number)

    ticket_price = ReservationService.calculate_price(params)                  #посчитать стоимость билета

    render json: {booking_number: booking_number, ticket_price: ticket_price } #рендер стоимости и номера брони
  end


  def cancel_reservation
    ticket = Ticket.find_by(booking_number: params["booking_number"])
    CancelReservationService.update_number_free_tickets(ticket)
    ticket.destroy

    render json: { result: "Бронь отменена" }
  end


  def buying_ticket #params { full_name, document_type, document_number, booking_number}
    user   = ByingTicketService.user_search(params)                   # поиск юзера в базе
    ticket = Ticket.find_by(booking_number: params["booking_number"]) # поиск билета по номеру брони

    ByingTicketService.checking_user_tickets(user ,ticket) # проверка, есть ли у юзера билет на сегодщняшнюю дату

    ticket.update(status: "bought") #продаем билет
    user.tickets << ticket
    ticket.users << user

    render json: {result: "Билет куплен"}
  end

end
