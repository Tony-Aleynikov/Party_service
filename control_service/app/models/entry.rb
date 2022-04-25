class Entry < ApplicationRecord
  enum status: { inside: 0, outside: 1 }
  enum ticket_category: { standart: 0, vip: 1 }
  enum document_type: { passport: 0, birth_certificate: 1, driver_license: 2 }
end
