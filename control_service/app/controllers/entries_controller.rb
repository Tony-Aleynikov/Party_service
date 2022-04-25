class EntriesController < ApplicationController
  def standart #params {ticket_number}
    ticket_information = EntryService.get_data(params)                               #запрос данных от первого сервиса
    ticket_entry       = Entry.find_by(ticket_number: params["ticket_number"])&.last #поиск записи с таким номером билета

    check = EntryService.standart_check(ticket_information, ticket_entry)                    #проверка при входе

    EntryService.add_entry(ticket_information, true, "inside")                       #запись в базу

    render json: check

    rescue Faraday::Error
      return render json: {result: "Не удалось получить информацию о билете" }
  end

  def vip
    ticket_information = EntryService.get_data(params)                               #запрос данных от первого сервиса
    ticket_entry       = Entry.where(ticket_number: params["ticket_number"]).last #поиск записи с таким номером билета

    check = EntryService.vip_check(ticket_information, ticket_entry)                         #проверка при входе

    EntryService.add_entry(ticket_information, true, "inside")                       #запись в базу

    render json: check

    rescue Faraday::Error
      return render json: {result: "Не удалось получить информацию о билете" }
  end

  def exit
    ticket_information = EntryService.get_data(params)                              #запрос данных от первого сервиса

    EntryService.add_entry(ticket_information, true, "outside")                     #запись в базу

    render json: {result: true }

    rescue Faraday::Error
      return render json: {result: "Не удалось получить информацию о билете" }
  end
end
