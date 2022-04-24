class TicketSellingController < ApplicationController
  def reservation
    #params {event_date:, ticket_category}  #Time.current.strftime("%m/%d/%Y") => "04/24/2022"

    ReservationService.event_search(params)       #проверочка, есть ли мероприятие с такой датой
    ReservationService.search_free_tickets(params) #проверка, остались ли билеты на это мероприятие

    ticket_number  = Time.current.to_i.to_s
    booking_number = Time.current.to_i.to_s

    ReservationService.create_ticket(params, ticket_number, booking_number) #создать билет
    ReservationService.update_number_free_tickets(params)     #обновить количество свободных билетов
                                                                #отправить запрос во 2 сервис о брони
    ticket_price = ReservationService.calculate_price(params) #посчитать стоимость билета

    render json: {booking_number: booking_number, ticket_price: ticket_price } #рендер стоимости и номера брони
  end

  def cancel_reservation
    ticket = Ticket.find_by(booking_number: params["booking_number"])
    CancelReservationService.update_number_free_tickets(ticket)
    ticket.destroy

    render json: { result: "Бронь отменена" }
  end

  def buying_ticket
  end
end
