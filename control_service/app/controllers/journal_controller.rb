class JournalController < ApplicationController
  def all_entries
    entries = Entry.all

    render json: { entries: entries }
  end

  def sorted_entries
    entries = JournalService.sorting(params)

    render json: { entries: entries }
  end
end
