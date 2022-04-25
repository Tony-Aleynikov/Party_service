class Ticket < ApplicationRecord
  has_and_belongs_to_many :users
  enum status: { booked: 0, bought: 1, blocked: 2 }
  enum ticket_category: { standart: 0, vip: 1 }
end
