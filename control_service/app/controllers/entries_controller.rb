class EntriesController < ApplicationController
  def standart

  end

  def vip
  end

  def exit
    ticket_information = EntryService.get_data(params)  #запрос данных от первого сервиса

    EntryService.add_entry(ticket_information, true, "outside") #запись в базу

    render json: {result: true }

    rescue Faraday::Error
      return render json: {result: "Не удалось получить информацию о билете" }
  end
end
