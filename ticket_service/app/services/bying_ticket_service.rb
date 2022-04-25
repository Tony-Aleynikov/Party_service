class ByingTicketService

  def self.user_search(params)
    user = User.find_by(full_name:       params["full_name"],
                        document_type:   params["document_type"],
                        document_number: params["document_number"])

    if user == nil # если юзера нет, то создать его
      user = User.create(full_name: params["full_name"],
                         document_type: params["document_type"],
                         document_number: params["document_number"] )
    end
  end

  def self.checking_user_tickets(user ,ticket)
    if user.tickets.find_by(event_date: ticket.event_date)
      return render json: { result: "У вас уже есть билет на сегодняшнее мероприятие" }
    end
  end

end
