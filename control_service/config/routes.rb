Rails.application.routes.draw do
  get 'journal/all_entries'
  get 'journal/sorted_entries'
  get 'ticket_block/block'
  get 'entries/standart'
  get 'entries/vip'
  get 'entries/exit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
